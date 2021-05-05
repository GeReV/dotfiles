# This is where brew stores its binary symlinks
local binroot="$(brew --config | awk '/HOMEBREW_PREFIX/ {print $2}')"/bin

ln -nfs "$DOTFILES/vendor/prezto" "${ZDOTDIR:-$HOME}/.zprezto"

ln -nfs "$DOTFILES/vendor/prezto/runcoms/zlogin" "$HOME/.zlogin"
ln -nfs "$DOTFILES/vendor/prezto/runcoms/zlogout" "$HOME/.zlogout"
ln -nfs "$DOTFILES/vendor/prezto/runcoms/zprofile" "$HOME/.zprofile"
ln -nfs "$DOTFILES/vendor/prezto/runcoms/zshenv" "$HOME/.zshenv"

# Create override directories.
mkdir -p $HOME/.zsh.before
mkdir -p $HOME/.zsh.after
mkdir -p $HOME/.zsh.prompts

# zsh
if [[ "$(type -p $binroot/zsh)" && "$(cat /etc/shells | grep -q "$binroot/zsh")" ]]; then
  e_header "Adding $binroot/zsh to the list of acceptable shells"
  echo "$binroot/zsh" | sudo tee -a /etc/shells >/dev/null
fi
if [[ "$(dscl . -read ~ UserShell | awk '{print $2}')" != "$binroot/zsh" ]]; then
  e_header "Making $binroot/zsh your default shell"
  sudo chsh -s "$binroot/zsh" "$USER" >/dev/null 2>&1
  e_arrow "Please exit and restart all your shells."
fi
