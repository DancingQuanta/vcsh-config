#!/bin/sh

set -e

: "${XDG_CONFIG_HOME:="$HOME/.config"}"

# XXX This should really be a normal post-pull hook, but vcsh lacks
# per-repository pull/push hooks, see
# https://github.com/RichiH/vcsh/issues/213

echo "Updating submodules..."
vcsh foreach -g "$XDG_CONFIG_HOME/vcsh/hooks-available/submodule-update.sh"
