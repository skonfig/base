# -*- mode: sh; indent-tabs-mode: t -*-
#
# 2020,2022 Dennis Camera (dennis.camera at riiengineering.ch)
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

# NOTE: older releases of OpenWrt do not include sbin in PATH but uci(1) is
#       installed in /sbin.
PATH=/bin:/sbin:/usr/bin:/usr/sbin

changes=$(uci changes)

if test -n "${changes}"
then
	echo 'Uncommited UCI changes were found on the target:'
	printf '%s\n\n' "${changes}"
	echo 'This can be caused by manual changes or due to a previous failed run.'
	echo 'Please investigate the situation, revert or commit the changes, and try again.'
	exit 1
fi >&2

check_errors() {
	# reads stdin and forwards non-empty lines to stderr.
	# returns 0 if stdin is empty, else 1.
	! grep -e . >&2
}

commit() {
	uci commit
}

rollback() {
	printf '\nAn error occurred when trying to commit UCI transaction!\n' >&2

	uci changes \
	| sed -e 's/^-//' -e 's/\..*\$//' \
	| LC_ALL=C sort -u \
	| while read -r _package
	  do
		  uci revert "${_package}"
		  echo "${_package}"  # for logging
	  done \
	| awk '
	  BEGIN { printf "Reverted changes in: " }
	  { printf "%s%s", (FNR > 1 ? ", " : ""), $0 }
	  END { printf "\n" }' >&2

	return 1
}

uci_apply() {
	# shellcheck disable=SC2015
	uci batch 2>&1 | check_errors && commit || rollback
}
