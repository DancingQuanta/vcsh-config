#!/bin/sh

set -e

# Only the same instance of vcsh that had the working tree fully populated is
# allowed to repopulate it sparsely.
LOCKDIR=/run/lock/vcsh

# If LOCKDIR does not exist it means that the lock is not active so there's no
# need to do anything.
[ -d "$LOCKDIR" ] || exit 0

LOCKPID=$(cat "$LOCKDIR/pid")
# Use the parent pid because the hooks are launched as children of vcsh.
[ "$LOCKPID" = $PPID ] || { echo "Repository entered from another vcsh instance. Aborting." 1>&2; exit 1; }

: "${XDG_CONFIG_HOME:="$HOME/.config"}"

# shellcheck source=/dev/null
. "$XDG_CONFIG_HOME/vcsh/hooks-available/enable-sparse-checkout.sh"

# shellcheck source=/dev/null
. "$XDG_CONFIG_HOME/vcsh/hooks-available/update-working-tree.sh"

# Unlock the working tree.
rm -rf "$LOCKDIR"
