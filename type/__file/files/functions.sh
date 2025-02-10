# -*- mode: sh; indent-tabs-mode: t -*-
# shellcheck shell=sh
#
# 2023 Dennis Camera (dennis.camera at riiengineering.ch)
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

shquot() {
	sed -e "s/'/'\\\\''/g" -e "1s/^/'/" -e "\$s/\$/'/" <<-EOF
	$*
	EOF
}

get_current_value() {
	test -s "$1" || return 0

	awk -v name="$2" -v value="$3" '{
		if (1 == index($0, name ":")) {
			print ((value ~ /^[0-9]+$/) ? $2 : $3)
		}
	}' "$1"
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

	# shellcheck disable=SC2016
	${_remote_path:+printf 'PATH=${PATH}:%s\n' "${_remote_path}"}
}
