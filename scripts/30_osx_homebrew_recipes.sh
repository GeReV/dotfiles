# OSX-only stuff. Abort if not OSX.
is_osx || return 0

eval "$(/opt/homebrew/bin/brew shellenv)"

# Exit if Homebrew is not installed.
[[ ! "$(type -p brew)" ]] && e_error "Brew recipes need Homebrew to install." && return 1

# Homebrew recipes
recipes=(
  ack
  android-platform-tools
  asdf
  awscli
  bat

  # Install GNU core utilities (those that come with macOS are outdated).
  # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
  coreutils

  cowsay

  # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
  findutils

  fnm
  fd
  exa
  git
  git-lfs
  git-town
  gmp
  gnu-sed
  gnupg
  grep
  gs
  htop
  id3tool
  imagemagick
  jq
  lesspipe
  lua
  lynx
  m-cli
  man2html
  mercurial

  # Install some other useful utilities like `sponge`.
  moreutils

  nmap
  openssh
  p7zip
  pigz
  pv
  postgresql
  reattach-to-user-namespace
  rlwrap
  ripgrep
  screen
  sfnt2woff
  sfnt2woff-zopfli
  smartmontools
  ssh-copy-id
  telnet
  terminal-notifier
  the_silver_searcher
  thefuck
  tmux
  tmux-xpanes
  tree
  vbindiff
  vim
  wget
  woff2
  xh
  xplr
  zopfli
  zsh
  zsh-completions
)

brew_install_recipes

ln -fs "${HOMEBREW_PREFIX}/bin/gsha256sum" "${HOMEBREW_PREFIX}/bin/sha256sum"

# This is where brew stores its binary symlinks
local binroot="$(brew --config | awk '/HOMEBREW_PREFIX/ {print $2}')"/bin

# htop
if [[ "$(type -p $binroot/htop)" ]] && [[ "$(stat -L -f "%Su:%Sg" "$binroot/htop")" != "root:wheel" ]]; then
  e_header "Updating htop permissions"
  sudo chown root:wheel "$binroot/htop"
  sudo chmod u+s "$binroot/htop"
fi

# bash
if [[ "$(type -p $binroot/zsh)" && "$(cat /etc/shells | grep -q "$binroot/zsh")" ]]; then
  e_header "Adding $binroot/zsh to the list of acceptable shells"
  echo "$binroot/zsh" | sudo tee -a /etc/shells >/dev/null
fi
if [[ "$(dscl . -read ~ UserShell | awk '{print $2}')" != "$binroot/zsh" ]]; then
  e_header "Making $binroot/zsh your default shell"
  sudo chsh -s "$binroot/zsh" "$USER" >/dev/null 2>&1
  e_arrow "Please exit and restart all your shells."
fi
