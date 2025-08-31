#
# 2025 Dennis Camera (dennis.camera at riiengineering.ch)
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

# We need to shorten options for both groupmod and groupadd since on
# some systems (such as *BSD, Darwin) those commands do not handle GNU
# style long options.
shorten_groupmod_property() {
	case $1
	in
		(gid)
			echo '-g' ;;
		(password)
			echo '-p' ;;
		(system)
			echo '-r' ;;
	esac
}

properties_to_groupmod_argv() {
	for __group_prop in "$@"
	do
		# we need to shorten options for both groupmod and groupadd since on
		# some systems (such as *BSD, Darwin) those commands do not handle
		# GNU-style long options.
		case ${__group_prop%%=*}
		in
			(gid)
				__groupmod_opt='-g' ;;
			(password)
				__groupmod_opt='-p' ;;
			(system)
				__groupmod_opt='-r' ;;
			(*)
				return 1 ;;
		esac

		case ${__groupmod_opt-},${__group_prop-}
		in
			(-*,*=*)  # valid option with value
				set -- "$@" "${__groupmod_opt}" "$(quote_ifneeded "${__group_prop#*=}")"
				;;
			(-*,*)  # valid option without value
				set -- "$@" "${__groupmod_opt}"
				;;
		esac
		shift
	done
	unset -v __group_prop __groupmod_opt

	# NOTE: use printf because echo may process escape sequences
	printf '%s' "$*"
}

do_create_group() {
	# usage: do_create_group name property[=value]...

	__do_group=${1:?}
	shift
	__do_argv=$(properties_to_groupmod_argv "$@")

	printf 'groupadd%s %s\n' \
		"${__do_argv:+ ${__do_argv}}" \
		"$(quote_ifneeded "${__do_group:?}")"

	unset -v __do_group __do_argv
}

do_modify_group() {
	# usage: do_modify_group name property=new-value...

	__do_group=${1:?}
	shift
	__do_argv=$(properties_to_groupmod_argv "$@")

	printf 'groupmod%s %s\n' \
		"${__do_argv:+ ${__do_argv}}" \
		"$(quote_ifneeded "${__do_group:?}")"

	unset -v __do_group __do_argv
}

do_delete_group() {
	# usage: do_delete_group name

	printf 'groupdel %s\n' \
		"$(quote_ifneeded "${1:?}")"
}
