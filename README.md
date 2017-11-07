                   _                            __ _       
    __   _____ ___| |__         ___ ___  _ __  / _(_) __ _ 
    \ \ / / __/ __| '_ \ _____ / __/ _ \| '_ \| |_| |/ _` |
     \ V / (__\__ \ | | |_____| (_| (_) | | | |  _| | (_| |
      \_/ \___|___/_| |_|      \___\___/|_| |_|_| |_|\__, |
                                                     |___/ 

My own vcsh root repository which will be installed by a bootstrap script before all other vcsh repos.
This repository is used with [vcsh] with the default directory layout, powered by [mr].
This repo contains default mr configuration and useful vcsh hooks.

This repo is based on [vcsh-home], [vcsh-root] and [vcsh-dotfiles].

# Requirements

- [mr] which requires perl
- [vcsh] which requires git

The above software could be installed by your favourite package manager or downloaded from their websites.

# Usage

A [bootstrap script], which resides in separate branch from this one, bootstraps this repo to install default vcsh and mr configuration (with the vcsh hooks, etc...).

The bootstrap operation can be executed in one line

    $ bash < <(curl -s "https://raw.githubusercontent.com/DancingQuanta/vcsh-config/bootstrap/bootstrap.sh")
    
# How does this bootstrapping process work?

Some of the vcsh hooks in this repo utilises sparse-checkout feature of git to ensure that common files such as `README.md` and `LICENSE` will not be checked out when cloning other vcsh repos.

[vcsh]: https://github.com/RichiH/vcsh (vcsh)
[mr]: http://kitenet.net/~joey/code/mr/ (http://kitenet.net/~joey/code/mr/)
[vcsh-home]: https://github.com/vdemeester/vcsh-home
[vcsh-root]: https://github.com/jwhitley/vcsh-root
[vcsh-dotfiles]: https://github.com/ek9/vcsh-dotfiles
[bootstrap]: https://github.com/DancingQuanta/vcsh-config/blob/bootstrap/bootstrap.sh

