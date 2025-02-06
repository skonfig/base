#!/bin/sh
#
# 2014 Daniel Heule (hda at sfs.biz)
# 2018 Darko Poljak (darko.poljak at gmail.com)
# 2020,2023 Dennis Camera (dennis.camera at riiengineering.ch)
#
# This file is part of skonfig-base.
#
# skonfig-base is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# skonfig-base is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with skonfig-base. If not, see <http://www.gnu.org/licenses/>.
#

key=$(cat "${__object:?}/parameter/key" 2>/dev/null \
   || echo "${__object_id:?}")
state=$(cat "${__object:?}/parameter/state")

file=$(cat "${__object:?}/parameter/file")

delimiter=$(cat "${__object:?}/parameter/delimiter")
value=$(cat "${__object:?}/parameter/value" 2>/dev/null \
   || echo "__CDIST_NOTSET__")
export key state delimiter value
if [ -f "${__object:?}/parameter/exact_delimiter" ]; then
    exact_delimiter=1
else
    exact_delimiter=0
fi
export exact_delimiter

tmpfile=$(mktemp "${file}.skonfig.XXXXXX")
# preserve ownership and permissions by copying existing file over tmpfile
if [ -f "$file" ]; then
    cp -p "$file" "$tmpfile"
else
    touch "$file"
fi

awk_bin=$(PATH=$(getconf PATH 2>/dev/null) && command -v awk || echo awk)

"${awk_bin}" -f - "$file" >"$tmpfile" <<"AWK_EOF"
BEGIN {
    # import variables in a secure way ..
    state=ENVIRON["state"]
    key=ENVIRON["key"]
    delimiter=ENVIRON["delimiter"]
    value=ENVIRON["value"]
    comment=ENVIRON["comment"]
    exact_delimiter=ENVIRON["exact_delimiter"]
    inserted=0
    lastline=""
    lastlinepopulated=0
    line=key delimiter value
}
# enter the main loop
{
    # I dont use regex, this is by design, so we can match against every value without special meanings of chars ...
    i = index($0,key)
    if(i == 1) {
        delval = substr($0,length(key)+1)
        delpos = index(delval,delimiter)
        if(delpos > 1) {
            spaces = substr(delval,1,delpos-1)
            sub(/[ \t]*/,"",spaces)
            if( length(spaces) > 0 ) {
                # if there are not only spaces between key and delimiter,
                # continue since we we are on the wrong line
                if(lastlinepopulated == 1) {
                    print lastline
                }
                lastline=$0
                lastlinepopulated=1
                next
            }
        }
        if(state == "absent") {
            if(lastline == comment) {
                # if comment is present, clear lastlinepopulated flag
                lastlinepopulated=0
            }
            # if absent, simple yump over this line
            next
        }
        else {
            # if comment is present and not present in last line
            if (lastlinepopulated == 1) {
                print lastline
                if( comment != "" && lastline != comment) {
                    print comment
                }
                lastlinepopulated=0
            }
            inserted=1
            # state is present, so insert correct line here
            print line
            lastline=line
            next
        }
    }
    else {
        if(lastlinepopulated == 1) {
            print lastline
        }
        lastline=$0
        lastlinepopulated=1
    }
}
END {
    if(lastlinepopulated == 1) {
        print lastline
    }
    if(inserted == 0 && state == "present" ) {
        if(comment != "" && lastline != comment){
            print comment
        }
        print line
    }
}
AWK_EOF
mv -f "$tmpfile" "$file"
