# OSX-only stuff. Abort if not OSX.
is_osx || return 0

# Provide Homebrew completions (if installed).
# See https://docs.brew.sh/Shell-Completion
if type brew &> /dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi