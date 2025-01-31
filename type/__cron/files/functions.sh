# NOTE: this file needs to be sourced.
#
# 2022 Dennis Camera (skonfig at dtnr.ch)
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

NL=$(printf '\n '); NL=${NL% }

quote() { printf '%s\n' "$*" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/'/"; }
count_lines() (
	IFS=${NL?}
	# shellcheck disable=SC2048,SC2086
	set -f -- $*; echo $#
)
