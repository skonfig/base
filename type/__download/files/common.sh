# -*- mode: sh; indent-tabs-mode: t -*-
# shellcheck shell=sh
#
# 2023 Dennis Camera (dennis.camera at riiengineering.ch
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

# prepare common variables

if test -f "${__object:?}/parameter/destination"
then
	remote_dst=$(cat "${__object:?}/parameter/destination")
else
	remote_dst="/${__object_id:?}"
fi

case ${gencode:-local}
in
	(local)
		cmd_get=$("${__type:?}/explorer/remote_cmd_get")
		cmd_sum=$("${__type:?}/explorer/remote_cmd_sum")
		;;
	(remote)
		cmd_get=$(cat "${__object:?}/explorer/remote_cmd_get")
		cmd_sum=$(cat "${__object:?}/explorer/remote_cmd_sum")
		;;
	(*)
		exit 1
		;;
esac


# functions

shquot() {
	sed -e "s/'/'\\\\''/g" -e "1s/^/'/" -e "\$s/\$/'/" <<-EOF
	$*
	EOF
}

remote_download_tmp() {
	# NOTE: this function must always print the same value
	printf '%s.skonfig__download.tmp\n' "${remote_dst:?}"
}

gencode_get() (
	# NOTE: $1 needs to be quoted properly for the target shell

	url=$(cat "${__object:?}/parameter/url")

	test -n "${cmd_get?}" || {
		echo 'download error: no usable utility' >&2
		return 1
	}

	download_tmp=${1:?no download_tmp given}

	# shellcheck disable=SC2059
	printf "${cmd_get:?} >%s\n" "$(shquot "${url}")" "${download_tmp}"
)

gencode_cksum() (
	# NOTE: $1 needs to be quoted properly for the target shell

	test -f "${__object:?}/parameter/sum" || return 0

	file=${1:?no file given}

	sum_should=$(cat "${__object:?}/parameter/sum")
	sum_should=${sum_should#*:}

	test -n "${cmd_sum?}" || {
		echo 'checksum verification error: no usable utility' >&2
		return 1
	}

	# shellcheck disable=SC2059
	cat <<-EOF
	sum_is=\$($(printf "${cmd_sum:?}" "${file}"))
	if test "\${sum_is}" != $(shquot "${sum_should}")
	then
	    printf 'checksum mismatch (%s != %s)\n' "\${sum_is}" $(shquot "${sum_should}") >&2
	    rm -f ${file}
	    exit 1
	fi
	EOF
)
