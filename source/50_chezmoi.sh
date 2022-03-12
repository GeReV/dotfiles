# Provide Chezmoi completions (if installed).
# See https://github.com/twpayne/chezmoi/blob/master/docs/REFERENCE.md
if command -v chezmoi > /dev/null; then
    eval "$(chezmoi completion zsh)"
fi
