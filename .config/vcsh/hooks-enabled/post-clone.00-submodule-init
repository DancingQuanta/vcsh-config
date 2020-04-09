#!/bin/sh

set -e

GIT_VERSION_MAJOR=$(git --version | sed -n 's/.* \([0-9]\{1,\}\)\..*/\1/p' )
GIT_VERSION_MINOR=$(git --version | sed -n 's/.* \([0-9]\{1,\}\)\.\([0-9]\{1,\}\).*/\2/p' )

if [ "$GIT_VERSION_MAJOR" -lt 2 ] || [ "$GIT_VERSION_MINOR" -lt 20 ];
then
  echo "Git >= 2.20 is required for submodules to work properly with vcsh" 1>&2
  exit 1
fi

git submodule sync --recursive
git submodule update --init --recursive
