#!/bin/sh

set -e

# Only one vcsh instance at a time can have the work dir fully populated.
LOCKDIR=/run/lock/vcsh

# Kill the parent process because vcsh does not catch the hook exit value.
# See: https://github.com/RichiH/vcsh/issues/251
mkdir "$LOCKDIR" 2>/dev/null || { echo "An instance of vcsh already entered a repository." 1>&2; kill -- -$PPID;}

# Lock on the parent pid because the hooks are launched as children of vcsh.
echo $PPID > "$LOCKDIR/pid"

# git read-tree manual page says this is the proper way to fully repopulate
# the working directory
git config core.sparseCheckout true
rm -f "$GIT_DIR/info/sparse-checkout"
echo "/*" > "$GIT_DIR/info/sparse-checkout"
git read-tree -mu HEAD
git config core.sparseCheckout false
