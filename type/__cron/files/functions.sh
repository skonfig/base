NL=$(printf '\n '); NL=${NL% }

quote() { printf '%s\n' "$*" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/'/"; }
count_lines() (
	IFS=${NL?}
	# shellcheck disable=SC2048,SC2086
	set -f -- $*; echo $#
)
