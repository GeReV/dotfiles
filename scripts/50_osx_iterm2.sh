# OSX-only stuff. Abort if not OSX.
is_osx || return 0

/usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Solarized Dark - Patched' dict" ~/Library/Preferences/com.googlecode.iterm2.plist
/usr/libexec/PlistBuddy -c "Merge '$SOURCE_DIR/config/iTerm2/Solarized Dark - Patched.itermcolors' :'Custom Color Presets':'Solarized Dark - Patched'" ~/Library/Preferences/com.googlecode.iterm2.plist

# https://github.com/skwp/dotfiles/blob/4f444cbc1343785fac223722fff6e382527b02bc/Rakefile#L190-L228
