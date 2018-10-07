#!/bin/sh

set -e

# Only the same instance of vcsh that had the work dir fully populated is
# allowed to repopulate it sparsely.
LOCKDIR=/run/lock/vcsh
[ -d "$LOCKDIR" ] || exit 0

LOCKPID=$(cat "$LOCKDIR/pid")
# Use the parent pid because the hooks are launched as children of vcsh.
[ "$LOCKPID" = $PPID ] || { echo "Repository entered from another vcsh instance. Aborting." 1>&2; exit 1; }

: "${XDG_CONFIG_HOME:="$HOME/.config"}"
. "$XDG_CONFIG_HOME/vcsh/hooks-available/sparse-checkout.sh"
git read-tree -mu HEAD

# Unlock the work dir.
rm -rf "$LOCKDIR"
