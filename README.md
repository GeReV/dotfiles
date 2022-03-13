# Dotfiles

My OSX / Ubuntu dotfiles.

## About this project

This repository is managed with [`chezmoi`](https://chezmoi.io).

The main attractions are:

- Sane macOS defaults from [Mathias Bynens' Dotfiles](https://github.com/mathiasbynens/dotfiles)
- Zsh with [Prezto](https://github.com/sorin-ionescu/prezto) and some configurations from [YADR](https://github.com/skwp/dotfiles)

## Installation

If `chezmoi` is already installed:

```sh
chezmoi init --apply -S ~/.dotfiles https://github.com/gerev/dotfiles.git
```

For a complete setup, including `chezmoi`:

### Ubuntu

```sh
sh -c "$(wget -q0- chezmoi.io/get)" -- init --apply -S ~/.dotfiles https://github.com/gerev/dotfiles.git
```

### macOS

Complete setup, including `chezmoi`:

```sh
sh -c "$(curl -fsSL chezmoi.io/get)" -- init --apply -S ~/.dotfiles https://github.com/gerev/dotfiles.git 
```

## Details

### Other subdirectories

* The `.chezmoiscripts` directory contains all setup scripts that are run once on setup.
* The `/bin` directory contains utility shell scripts. This directory is added to the path.
* The `/config` directory just exists. If a config file doesn't **need** to go in `~/`, reference it from the `/config` directory.
* The `/source` directory contains files that are sourced whenever a new shell is opened (in alphanumeric order, hence the funky names).
* The `/test` directory contains unit tests for especially complicated bash functions.
* The `/caches` directory contains cached files, used by some scripts or functions. It is created during setup.

### Setup scripts

#### OS X

* Minor XCode init via the [run_once_10_osx_xcode.sh](.chezmoiscripts/run_once_10_osx_xcode.sh.tmpl) script
* Homebrew via the [run_once_20_osx_homebrew.sh](.chezmoiscripts/run_once_20_osx_homebrew.sh.tmpl) script
* Homebrew recipes via the [run_once_30_osx_homebrew_recipes.sh](.chezmoiscripts/run_once_30_osx_homebrew_recipes.sh.tmpl) script
* Homebrew casks via the [run_once_30_osx_homebrew_casks.sh](.chezmoiscripts/run_once_30_osx_homebrew_casks.sh.tmpl) script
* iTerm2 theme in the [run_once_40_osx_iterm2.sh](.chezmoiscripts/run_once_40_osx_iterm2.sh.tmpl) script
* Final OS X setup step the [run_once_40_osx_macos.sh](.chezmoiscripts/run_once_40_osx_macos.sh.tmpl) script

#### Ubuntu
* APT packages via the [run_once_20_ubuntu_apt.sh](.chezmoiscripts/run_once_20_ubuntu_apt.sh.tmpl) script

#### Both
* Node.js and Ruby via ASDF, NVM, and `rbenv` in the [run_once_40_devtools.sh](.chezmoiscripts/run_once_40_devtools.sh.tmpl) script
* Zsh setup in the [run_once_40_zsh.sh](.chezmoiscripts/run_once_40_zsh.sh.tmpl) script

### OS X Notes

You need to have [XCode](https://developer.apple.com/downloads/index.action?=xcode) or, at the very minimum, the [XCode Command Line Tools](https://developer.apple.com/downloads/index.action?=command%20line%20tools), which are available as a much smaller download.

The easiest way to install the XCode Command Line Tools in OSX 10.9+ is to open up a terminal, type `xcode-select --install` and [follow the prompts](http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/).

_Tested in OSX 10.15_

_Tested in Ubuntu 21.04_

## License
Copyright (c) 2022 Amir Grozki  
Licensed under the MIT license.
