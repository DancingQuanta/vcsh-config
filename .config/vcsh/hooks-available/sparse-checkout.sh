#!/usr/bin/env sh
## DancingQuanta/vcsh-config - https://github.com/DancingQuanta/vcsh-config
## sparse-checkout.sh
## From https://git.ao2.it/config/vcsh.git/
## Sparse checkout files listed in "$GIT_DIR/info/sparse-checkout" upon
## pre-upgrade of a vcsh repo

: "${XDG_CONFIG_HOME:="$HOME/.config"}"

git config core.sparseCheckout true
rm -f "$GIT_DIR/info/sparse-checkout"
ln -s "$XDG_CONFIG_HOME/vcsh/sparse-checkout" "$GIT_DIR/info/sparse-checkout"
