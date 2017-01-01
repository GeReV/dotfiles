export PATH
# rbenv init.
PATH="$(path_remove $DOTFILES/vendor/rbenv/bin):$DOTFILES/vendor/rbenv/bin"
if [[ "$(type -p rbenv)" && ! "$(type -w _rbenv)" ]]; then
  eval "$(rbenv init -)"
fi
