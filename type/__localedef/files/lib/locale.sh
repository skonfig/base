# -*- mode: sh; indent-tabs-mode:t -*-
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

parse_locale() {
	# This function will split locales into their parts. Locale strings are
	# usually of the form: [language[_territory][.codeset][@modifier]]
	# For simplicity, language and territory are not separated by this function.
	# Old Linux systems were also using "english" or "german" as locale strings.
	# Usage: parse_locale locale_str lang_var codeset_var modifier_var
	eval "${2:?}"="$(expr "$1" : '\([^.@]*\)')"
	eval "${3:?}"="$(expr "$1" : '[^.]*\.\([^@]*\)')"
	eval "${4:?}"="$(expr "$1" : '.*@\(.*\)$')"
}

format_locale() {
	# Usage: format_locale language codeset modifier
	printf '%s' "$1"
	test -z "$2" || printf '.%s' "$2"
	test -z "$3" || printf '@%s' "$3"
	printf '\n'
}
