#!/usr/bin/env bash

source "{{ .chezmoi.sourceDir }}/source/00_common.sh"

ln -nfs "~/.zprezto/runcoms/zlogin" "$HOME/.zlogin"
ln -nfs "~/.zprezto/runcoms/zlogout" "$HOME/.zlogout"
ln -nfs "~/.zprezto/runcoms/zprofile" "$HOME/.zprofile"
ln -nfs "~/.zprezto/runcoms/zshenv" "$HOME/.zshenv"

# Create override directories.
mkdir -p $HOME/.zsh.before
mkdir -p $HOME/.zsh.after
mkdir -p $HOME/.zsh.prompts

# zsh
if is_osx; then
    # This is where brew stores its binary symlinks
    local binroot="$(brew --config | awk '/HOMEBREW_PREFIX/ {print $2}')"/bin

    if [[ "$(type -p $binroot/zsh)" && "$(cat /etc/shells | grep -q "$binroot/zsh")" ]]; then
      e_header "Adding $binroot/zsh to the list of acceptable shells"
      echo "$binroot/zsh" | sudo tee -a /etc/shells >/dev/null
    fi
    if [[ "$(dscl . -read ~ UserShell | awk '{print $2}')" != "$binroot/zsh" ]]; then
      e_header "Making $binroot/zsh your default shell"
      sudo chsh -s "$binroot/zsh" "$USER" >/dev/null 2>&1
      e_arrow "Please exit and restart all your shells."
    fi
else
    if [[ "$(type -p /usr/bin/zsh)" && "$(cat /etc/shells | grep -q "/usr/bin/zsh")" ]]; then
      e_header "Adding /usr/bin/zsh to the list of acceptable shells"
      echo "/usr/bin/zsh" | sudo tee -a /etc/shells >/dev/null
    fi
    if [[ "$(getent passwd $(id -un) | awk -F : '{print $NF}')" != "/usr/bin/zsh" ]]; then
      e_header "Making /usr/bin/zsh your default shell"
      sudo chsh -s "/usr/bin/zsh" "$USER" >/dev/null 2>&1
      e_arrow "Please exit and restart all your shells."
    fi
fi
