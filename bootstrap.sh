#!/bin/sh
## DancingQuanta/vcsh-config - https://github.com/DancingQuanta/vcsh-config 
## bootstrap.sh
## bootstrap.sh bootstraps the root vcsh by setting up useful hooks for vcsh 
## and configuring mr to be extendable.
##
## Needed software:
## - git
## - perl
## - mr
## - vcsh
##
## It is inspired by the bootstrap script by Vincend Demeester at
## https://github.com/vdemeester/vcsh-home/blob/bootstrap/bootstrap.sh
## and https://github.com/ek9/vcsh-dotfiles/blob/master/vcsh-dotfiles
## and https://gist.github.com/elerch/88ea951c9c4ec4c3c1604b8fc9167e53

# To run this without copy/paste the whole thing:
# bash < <(curl -s https://raw.githubusercontent.com/DancingQuanta/vcsh-config/bootstrap/bootstrap.sh)

## ---------------------------------------------------------------------------
## Variables
## ---------------------------------------------------------------------------
SELF="$(basename $0)"
VCSH_ROOT_NAME="vcsh-config"
VCSH_ROOT="https://github.com/DancingQuanta/$VCSH_ROOT_NAME"

## ---------------------------------------------------------------------------
## Functions
## ---------------------------------------------------------------------------
# *log*: a wrapper of echo to print stuff in a more colorful way
log() {
  ECHO_ARGS=""
  test "$1" = "-n" && {
    ECHO_ARGS="-n"
    shift
  }
  echo $ECHO_ARGS "$(tput sgr0)$(tput setaf 2)>$(tput bold)>$(tput sgr0) $*"
}
# *warn*: a wrapper of echo to print stuff in a more colorful way, warning
warn() {
  test "$1" = "-n" && {
    ECHO_ARGS="-n"
    shift
  }
  echo $ECHO_ARGS "$(tput sgr0)$(tput setaf 3)<$(tput bold)<$(tput sgr0) $*"
}
# *fatal*: a wrapper of echo to print stuff in a more colorful way, error
fatal () {
  test "$1" = "-n" && {
    ECHO_ARGS="-n"
    shift
  }
  echo $ECHO_ARGS "$(tput sgr0)$(tput setaf 9)<$(tput bold)<$(tput sgr0) $*" >&2
  exit $2
}
# *check_cmd* : check a command and fail if not present
check_cmd() {
    command -v $1 >/dev/null && {
        echo "   $1"
    } || {
        echo ""
        warn "$1 is not available"
        echo
        exit 1
    }
}

## ---------------------------------------------------------------------------
## Bootstrap
## ---------------------------------------------------------------------------

log "Checking required software"
check_cmd perl
check_cmd git
check_cmd vcsh
check_cmd mr

log "Cloning $VCSH_ROOT"
cd $HOME
# Clone the root vcsh repo, containing the mr configuration
[ ! -d ~/.config/vcsh/repo.d/$VCSH_ROOT_NAME.git ] && vcsh clone $VCSH_ROOT

# Fixup $VCSH_ROOT_NAME's working tree for the sparse checkout settings
log "Setting up $VCSH_ROOT_NAME"
vcsh $VCSH_ROOT_NAME read-tree -mu HEAD
mr update
