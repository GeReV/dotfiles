# Enable ASDF Extendable version manager (https://asdf-vm.com).
# This should replace all language-secific version managers.
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"

if [[ ! -d $ASDF_DATA_DIR ]] && type brew &> /dev/null; then
    ASDF_DATA_DIR="$(brew --prefix asdf)"
fi

# Provide ASDF completions (already loaded if using Homebrew).
if [ -s "$ASDF_DATA_DIR/completions" ]; then
    fpath=(${ASDF_DAAT_DIR}/completions $fpath)
    # initialise completions with ZSH's compinit
    autoload -Uz compinit && compinit
fi
