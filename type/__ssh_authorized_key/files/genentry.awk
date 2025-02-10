# -*- mode: awk; indent-tabs-mode: t -*-
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
# This script takes the --key, does some basic validation, and inserts
# forced --options and --comment if necessary.
#
# The exit status is:
#
#   0  if everything went well
#   1  if something went wrong
#   2  no public key was found in the key file
#   3  if the key could not be validated
#   4  if multiple keys were found in the key file

BEGIN {
	if (!ENVIRON["__object"]) { exit (e=1) }

	parameter_dir = ENVIRON["__object"] "/parameter"

	forced_options_file = parameter_dir "/option"
	if (has_forced_options = (getline l < forced_options_file) >= 0) {
		forced_options = l
		while (0 < (getline l < forced_options_file)) {
			forced_options = forced_options "," l
		}
		close(forced_options_file)
	}
	l = ""

	forced_comment_file = parameter_dir "/comment"
	if (has_forced_comment = (getline l < forced_comment_file) >= 0) {
		forced_comment = l
		while (0 < (getline l < forced_comment_file)) {
			forced_comment = forced_comment " " l
		}
		close(forced_comment_file)
	}
	l = ""

	e = 2
}

# skip comment lines
/^#/ { next }

/(ssh|ecdsa|sk)-[^ ]+/ {
	# public key line
	if (0 == e) exit (e=4)  # multiple keys detected
	e = 0

	raw_key = $0

	# validate key

	if (!/^(ssh|ecdsa|sk)-/) {
		options_len = length
		# collapse quoted sections (quotes cannot be nested as per OpenSSH code)
		gsub(/".*[^\\]"/, "\"\"")
		# remove options ($1)
		$1 = ""; $0 = substr($0, index($0, $2))
		options_len -= length
	}

	type_and_key = sprintf("%s %s", $1, $2)

	$0 = raw_key

	if (type_and_key !~ /^(ssh|ecdsa|sk)-[^ ]+ AAAA[A-Za-z0-9+\/=]+$/) {
		exit (e=3)
	}

	if (has_forced_comment) {
		# remove comment from --key first
		$0 = substr($0, 1, options_len + length(type_and_key))

		if (forced_comment) {
			$0 = $0 " " forced_comment
		}
	}

	if (has_forced_options) {
		# remove options from key first
		$0 = substr($0, 1 + options_len)

		if (forced_options) {
			$0 = forced_options " " $0
		}
	}

	print
}

END {
	exit e
}
