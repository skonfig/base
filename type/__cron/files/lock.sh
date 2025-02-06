#!/bin/sh -e
#
# 2020,2022 Dennis Camera (dennis.camera at riiengineering.ch)
#
# This file is part of skonfig-base.
# It was originally written for __package_opkg’s pkg_status explorer.
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

: "${__object:?}" "${__object_id:?}"  # assert __object and __object_id is set
__type_path=${__object%%"${__object_id}"*}
readonly __type_path
test -d "${__type_path}" || { echo 'Cannot determine __type_path' >&2; exit 1; }
LOCKFILE="${__type_path%/*/*/*}/.cdist_crontab.lock"
readonly LOCKFILE

if command -v shlock >/dev/null 2>&1
then
	# NetBSD
	_lock() {
		until shlock -p $$ -f "${LOCKFILE:?}"
		do
			sleep 1
		done
	}
	_unlock() {
		# assert the current shell owns the lock
		echo $$ | cmp -s "${LOCKFILE:?}" - || return 1
		rm "${LOCKFILE:?}"
	}
elif command -v flock >/dev/null 2>&1 \
	&& flock 2>&1 | grep -q ' \(-x\|-u\)'
then
	# use flock on FD 9
	# NOTE: old util-linux versions don't support the -x and -u arguments.
	_lock() {
		if test "$(uname -s)" = 'NetBSD'
		then
			# required for opening of FDs
			set -o posix
		fi

		exec 9<>"${LOCKFILE:?}"
		flock -x 9
		echo $$>&9
	}
	_unlock() {
		:>"${LOCKFILE:?}"
		flock -u 9
		exec 9<&-
	}
elif command -v lockfile >/dev/null 2>&1
then
	# use lockfile (from procmail)
	_lock() {
		lockfile "${LOCKFILE}"
	}
	_unlock() {
		rm -f "${LOCKFILE}"
	}
else
	# fallback to mkdir if flock is missing
	_lock() {
		until mkdir "${LOCKFILE:?}.dir" 2>/dev/null
		do
			while test -d "${LOCKFILE}.dir"
			do
				# DEBUG:
				# printf 'Locked by PID: %u\n' "$(cat "${LOCKFILE}.dir/pid")"
				sleep 1
			done
		done
		echo $$ >"${LOCKFILE:?}.dir/pid"
	}
	_unlock() {
		test -d "${LOCKFILE}.dir" || return 0
		if test -s "${LOCKFILE}.dir/pid"
		then
			test "$(cat "${LOCKFILE}.dir/pid")" = $$ || return 1
			rm "${LOCKFILE:?}.dir/pid"
		fi
		rmdir "${LOCKFILE:?}.dir"
	}
fi

trap _unlock EXIT
_lock
