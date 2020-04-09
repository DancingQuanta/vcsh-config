#!/bin/sh

set -e

# If the vcsh repository does not exist, exit without doing anything.
[ -d "$GIT_DIR" ] || exit 0

: "${XDG_CONFIG_HOME:="$HOME/.config"}"

git config core.sparseCheckout true
rm -f "$GIT_DIR/info/sparse-checkout"
ln -s "$XDG_CONFIG_HOME/vcsh/sparse-checkout" "$GIT_DIR/info/sparse-checkout"
