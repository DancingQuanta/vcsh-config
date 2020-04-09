#!/bin/sh

# Verify if the current branch is valid before updating the working tree.
# This avoids errors with empty repositories which would only confuse the
# user.
if git rev-parse --verify HEAD >/dev/null 2>&1;
then
  git read-tree -mu HEAD
fi

