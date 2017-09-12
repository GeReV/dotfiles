export PATH
# rbenv init.
PATH="$(path_remove $DOTFILES/vendor/rbenv/bin):$DOTFILES/vendor/rbenv/bin"
if [[ "$(typeset -f rbenv > /dev/null)" && ! "$(typeset -f _rbenv > /dev/null)" ]]; then
  eval "$(rbenv init -)"
fi
