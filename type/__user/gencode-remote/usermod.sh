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

properties_to_usermod_argv() {
	for __do_arg in "$@"
	do
		# we need to shorten options for both usermod and useradd since on some
		# systems (such as *BSD, Darwin) those commands do not handle GNU-style
		# long options.
		case ${__do_arg%%=*}
		in
			(comment)
				__do_opt='-c' ;;
			(home)
				__do_opt='-d' ;;
			(gid)
				__do_opt='-g' ;;
			(groups)
				__do_opt='-G' ;;
			(password)
				__do_opt='-p' ;;
			(shell)
				__do_opt='-s' ;;
			(uid)
				__do_opt='-u' ;;
			(create-home)
				__do_opt='-m' ;;
			(remove-home|system)
				__do_opt='-r' ;;
			(*)
				return 1 ;;
		esac

		case ${__do_opt-},${__do_arg-}
		in
			(-*,*=*)  # valid option with value
				set -- "$@" "${__do_opt:?}" "${__do_arg#*=}" ;;
			(-*,*)  # valid option without value
				set -- "$@" "${__do_opt:?}" ;;
		esac
		shift
	done
	unset -v __do_arg __do_opt

	quote_ifneeded "$@"
}

usermod_pre_commands() {
	case ${os:?}
	in
		(openwrt)
			# NOTE: older releases of OpenWrt do not include sbin in PATH, but
			#       user* utilities are installed in /usr/sbin.
			echo 'PATH=/bin:/sbin:/usr/bin:/usr/sbin'
			;;
	esac
}

do_create_user() {
	# usage: do_create_user username property[=value]...

	__do_user=${1:?}
	shift
	__do_argv=$(properties_to_usermod_argv "$@")

	usermod_pre_commands
	printf 'useradd%s %s\n' \
		"${__do_argv:+ ${__do_argv}}" \
		"$(quote_ifneeded "${__do_user:?}")"

	unset -v __do_user __do_argv
}

do_modify_user() {
	# usage: do_modify_user username property=new-value...

	__do_user=${1:?}
	shift
	__do_argv=$(properties_to_usermod_argv "$@")

	usermod_pre_commands
	printf 'usermod%s %s\n' \
		"${__do_argv:+ ${__do_argv}}" \
		"$(quote_ifneeded "${__do_user:?}")"

	unset -v __do_user __do_argv
}

do_delete_user() {
	# usage: do_delete_user username property[=value]...

	__do_user=${1:?}
	shift
	__do_argv=$(properties_to_usermod_argv "$@")

	usermod_pre_commands
	printf 'userdel%s %s\n' \
		"${__do_argv:+ ${__do_argv}}" \
		"$(quote_ifneeded "${__do_user:?}")"

	unset -v __do_user __do_argv
}
