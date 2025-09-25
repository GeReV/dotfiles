# Initialize rbenv.
source "$SOURCE_DIR/source/50_ruby.sh"

e_header "Setting up development tools:"

command -v git >/dev/null 2>&1 || {
    error "git is not installed"
    exit 1
}

ASDF_VERSION="${ASDF_VERSION:-v0.18.0}"

# Install ASDF Version Manager
# https://asdf-vm.com/
if ! command -v brew > /dev/null; then
    e_arrow "Installing/updating ASDF Extendable Version Manager...\n"
    export ASDF_DATA_DIR="${ASDF_DIR:-$HOME/.asdf}" && (
        if [ ! -d "$ASDF_DATA_DIR" ]; then
            mkdir "$ASDF_DATA_DIR"

            wget "https://github.com/asdf-vm/asdf/releases/download/$ASDF_VERSION/asdf-$ASDF_VERSION-linux-amd64.tar.gz" -O /tmp/asdf-$ASDF_VERSION.tar.gz

            tar -xvf /tmp/asdf-$ASDF_VERSION.tar.gz "$HOME/bin"
        fi
    )

    mkdir -p "$ASDF_DATA_DIR/completions"

    asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"
fi

e_arrow "Installing/updating ASDF plugins...\n"
asdf plugin add golang
asdf plugin add nodejs
asdf plugin add python
asdf plugin add ruby
asdf plugin add rust
asdf plugin update --all

asdf install golang latest
asdf install nodejs latest
asdf install python latest
asdf install ruby latest
asdf install rust latest

# Install UV for Python
curl -LsSf https://astral.sh/uv/install.sh | sh

e_success "Done.\n\n"
