# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew recipes need Homebrew to install." && return 1

# Homebrew recipes
recipes=(
  ack
  android-platform-tools
  awscli

  # Install GNU core utilities (those that come with macOS are outdated).
  # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
  coreutils

  cowsay

  # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
  findutils

  git
  git-lfs
  gmp
  gnupg
  grep
  gs
  htop
  id3tool
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
  wget
  woff2
  zopfli
  zsh
  zsh-completions
)

brew_install_recipes

ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install `wget` with IRI support.
brew install wget --with-iri

brew install vim --with-override-system-vi

brew install imagemagick --with-webp

# Misc cleanup!

# This is where brew stores its binary symlinks
local binroot="$(brew --config | awk '/HOMEBREW_PREFIX/ {print $2}')"/bin

# htop
if [[ "$(type -P $binroot/htop)" ]] && [[ "$(stat -L -f "%Su:%Sg" "$binroot/htop")" != "root:wheel" ]]; then
  e_header "Updating htop permissions"
  sudo chown root:wheel "$binroot/htop"
  sudo chmod u+s "$binroot/htop"
fi

# bash
if [[ "$(type -P $binroot/zsh)" && "$(cat /etc/shells | grep -q "$binroot/zsh")" ]]; then
  e_header "Adding $binroot/zsh to the list of acceptable shells"
  echo "$binroot/zsh" | sudo tee -a /etc/shells >/dev/null
fi
if [[ "$(dscl . -read ~ UserShell | awk '{print $2}')" != "$binroot/zsh" ]]; then
  e_header "Making $binroot/zsh your default shell"
  sudo chsh -s "$binroot/zsh" "$USER" >/dev/null 2>&1
  e_arrow "Please exit and restart all your shells."
fi
