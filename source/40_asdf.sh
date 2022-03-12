# Enable ASDF Extendable version manager (https://asdf-vm.com).
# This should replace all language-secific version managers.
ASDF_DIR="${ASDF_DIR:-$HOME/.asdf}"
if [[ ! -d $ASDF_DIR ]] && type brew &> /dev/null; then
    ASDF_DIR="$(brew --prefix asdf)"
fi
[ -s "$ASDF_DIR/asdf.sh" ] && \. "$ASDF_DIR/asdf.sh"

# Provide ASDF completions (already loaded if using Homebrew).
if [ -s "$ASDF_DIR/completions" ]; then
    fpath=(${ASDF_DIR}/completions $fpath)
    # initialise completions with ZSH's compinit
    autoload -Uz compinit
    compinit
fi