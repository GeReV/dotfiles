# OSX-only stuff. Abort if not OSX.
is_osx || return 0

# Exit if Homebrew is not installed.
[[ ! "$(type -p brew)" ]] && e_error "Brew casks need Homebrew to install." && return 1

# Ensure the cask kegs are installed.
kegs=(
  homebrew/cask-drivers
  homebrew/cask-fonts
  homebrew/cask-versions
  bramstein/webfonttools
)
brew_tap_kegs

# Hack to show the first-run brew-cask password prompt immediately.
brew info this-is-somewhat-annoying 2>/dev/null || true

# Homebrew casks
casks=(
  # Applications
  alfred
  alt-tab
  android-platform-tools
  chromium
  discord
  docker
  ferdi
  firefox
  gimp
  google-chrome
  gyazo
  hex-fiend
  iterm2
  karabiner-elements
  licecap
  macvim
  ngrok
  numi
  rectangle
  slack
  steam
  visual-studio-code
  vlc
  xscreensaver
  # Quick Look plugins
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-csv
  quicklook-json
  quicknfo
  suspicious-package
  webpquicklook
)

# Install Homebrew casks.
casks=($(setdiff "${casks[*]}" "$(brew cask list 2>/dev/null)"))
if (( ${#casks[@]} > 0 )); then
  e_header "Installing Homebrew casks: ${casks[*]}"
  for cask in "${casks[@]}"; do
    brew install --cask $cask
  done
fi

# Work around colorPicker symlink issue.
# https://github.com/caskroom/homebrew-cask/issues/7004
cps=()
for f in ~/Library/ColorPickers/*.colorPicker; do
  [[ -L "$f" ]] && cps=("${cps[@]}" "$f")
done

if (( ${#cps[@]} > 0 )); then
  e_header "Fixing colorPicker symlinks"
  for f in "${cps[@]}"; do
    target="$(readlink "$f")"
    e_arrow "$(basename "$f")"
    rm "$f"
    cp -R "$target" ~/Library/ColorPickers/
  done
fi