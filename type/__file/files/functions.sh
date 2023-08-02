# -*- mode: sh; indent-tabs-mode: t -*-
# shellcheck shell=sh

shquot() {
	sed -e "s/'/'\\\\''/g" -e "1s/^/'/" -e "\$s/\$/'/" <<-EOF
	$*
	EOF
}

get_current_value() {
	test -s "${stat_file}" || return 0

	awk -v name="$1" -v value="$2" '{
		if (1 == index($0, name ":")) {
			print ((value ~ /^[0-9]+$/) ? $2 : $3)
		}
	}' "${stat_file}"
}

set_remote_path() {
	${_remote_path+return 0}  # singleton

	case $(cat "${__global:?}/explorer/os")
	in
		(netbsd)
			# NOTE: NetBSD stores the chown executables in /sbin,
			#       but /sbin is not in the default PATH when connecting
			#       over SSH.
			case ${1-}
			in
				(chown|'')
					_remote_path=/usr/sbin:/sbin
					;;
			esac
			;;
	esac

	${_remote_path:+printf 'PATH=${PATH}:%s\n' "${_remote_path}"}
}
