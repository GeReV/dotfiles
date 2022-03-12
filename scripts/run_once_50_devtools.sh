#!/usr/bin/env bash

source 00_common.sh

e_header "Setting up development tools:"

command -v git >/dev/null 2>&1 || {
    error "git is not installed"
    exit 1
}

# Install ASDF Versionn Manager
# https://asdf-vm.com/
if ! command -v brew > /dev/null;; then
    e_arrow "Installing/updating ASDF Extendable Version Manager...\n"
    export ASDF_DIR="${ASDF_DIR:-$HOME/.asdf}" && (
        ASDF_NEW=false
        if [ ! -d "$ASDF_DIR" ]; then
            git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR"
            ASDF_NEW=true
        fi
        cd "$ASDF_DIR"
        if [ $ASDF_NEW ]; then
            git checkout "$(git describe --abbrev=0 --tags)"
        else
            asdf update
        fi
    ) && \. "$ASDF_DIR/nvm.sh" && ([ -z "$BASH_VERSION" ] || \. "$ASDF_DIR/completions/asdf.bash")
fi

e_arrow "Installing/updating ASDF plugins...\n"
asdf plugin add golang
asdf plugin add nodejs
asdf plugin add python
asdf plugin add ruby
asdf plugin update --all

e_arrow "Importing PGP keyrings for ASDF plugins...\n"
"$HOME"/.asdf/plugins/nodejs/bin/import-release-team-keyring

# asdf install golang latest
asdf install nodejs latest

# Install NVM
e_arrow "Installing/updating Node Version Manager...\n"
export NVM_DIR="$HOME/.nvm" && (
    NVM_NEW=false
    if [ ! -d "$NVM_DIR" ]; then
        git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
        NVM_NEW=true
    fi
    cd "$NVM_DIR"
    if [ ! $NVM_NEW ]; then
        git fetch --tags origin
    fi
    HASH=$(git describe --abbrev=0 --tags --match "v[0-9]*" "$(git rev-list --tags --max-count=1)")
    git checkout "$HASH"
) && \. "$NVM_DIR/nvm.sh" && \. "$NVM_DIR/bash_completion"

# Install Node.js
e_arrow "Installing/updating Node.js...\n"
nvm install node

e_success "Done.\n\n"
