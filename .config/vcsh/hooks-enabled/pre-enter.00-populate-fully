#!/bin/sh

set -e

# If the vcsh repository does not exist, exit without doing anything.
[ -d "$GIT_DIR" ] || exit 0

# Only one vcsh instance at a time can have the working tree fully populated.
LOCKDIR=/run/lock/vcsh

# If mkdir fails it means that the lock dir already exists and the lock is
# already active.
if ! mkdir "$LOCKDIR" 2>/dev/null;
then
  echo "An instance of vcsh already entered a repository." 1>&2

  # Exit vcsh if the process which keeps the lock is still alive.
  if kill -0 "$(cat "$LOCKDIR/pid")" 2>/dev/null;
  then
    # Kill the parent process instead of just bailing out because vcsh does
    # not catch the hook exit value.
    # See: https://github.com/RichiH/vcsh/issues/251
    kill -- -$PPID
  else
    echo "The instance which entered the repository earlier does not exist anymore." 1>&2
    echo "Continuing anyway." 1>&2
  fi
fi

# Lock on the parent pid because the hooks are launched as children of vcsh.
echo $PPID > "$LOCKDIR/pid"

# Verify if the current branch is valid before updating the working tree.
# This avoids errors with empty repositories which would only confuse the
# user.
if git rev-parse --verify HEAD >/dev/null 2>&1;
then
  # git read-tree manual page says this is the proper way to fully repopulate
  # the working tree.
  git config core.sparseCheckout true
  rm -f "$GIT_DIR/info/sparse-checkout"
  echo "/*" > "$GIT_DIR/info/sparse-checkout"
  RET=0
  git read-tree -mu HEAD || RET=$?
  git config core.sparseCheckout false

  # if updating the working tree failed exit the whole vcsh process to prevent
  # entering the repository.
  if [ $RET -ne 0 ];
  then
    echo "Fix the problems before entering the repository." 1>&2
    kill -- -$PPID
  fi
fi
