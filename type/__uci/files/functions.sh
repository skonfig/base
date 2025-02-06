# -*- mode: sh; indent-tabs-mode: t -*-
#
# 2020 Dennis Camera (dennis.camera at riiengineering.ch)
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

in_list() {
	printf '%s\n' "$@" | { grep -qxF "$(read -r ndl; echo "${ndl}")"; }
}

quote() {
	for _arg
	do
		shift
		if test -n "$(printf %s "${_arg}" | tr -d -c '\t\n \042-\047\050-\052\073-\077\133\\`|~' | tr -c '' '.')"
		then
			# needs quoting
			set -- "$@" "$(printf "'%s'" "$(printf %s "${_arg}" | sed -e "s/'/'\\\\''/g")")"
		else
			set -- "$@" "${_arg}"
		fi
	done
	unset _arg

	# NOTE: Use printf because POSIX echo interprets escape sequences
	printf '%s' "$*"
}

uci_cmd() {
	# Usage: uci_cmd [UCI ARGUMENTS]...
	mkdir -p "${__object:?}/files"
	printf '%s\n' "$(quote "$@")" >>"${__object:?}/files/uci_batch.txt"
}

uci_validate_name() {
	# like util.c uci_validate_name()
	test -n "$*" && test -z "$(echo "$*" | tr -d '[:alnum:]_')"
}

uci_validate_tuple() (
	tok=${1:?}
	case $tok
	in
		(*.*.*)
			# check option
			option=${tok##*.}
			uci_validate_name "${option}" || {
				printf 'Invalid option: %s\n' "${option}" >&2
				return 1
			}
			tok=${tok%.*}
			;;
		(*.*)
			# no option (section definition)
			;;
		(*)
			printf 'Invalid tuple: %s\n' "$1" >&2
			return 1
			;;
	esac

	case ${tok#*.}
	in
		(@*) section=$(expr "${tok#*.}" : '@\(.*\)\[-*[0-9]*\]$') ;;
		(*)  section=${tok#*.} ;;
	esac
	uci_validate_name "${section}" || {
		printf 'Invalid section: %s\n' "${1#*.}" >&2
		return 1
	}

	config=${tok%%.*}
	uci_validate_name "${config}" || {
		printf 'Invalid config: %s\n' "${config}" >&2
		return 1
	}
)
