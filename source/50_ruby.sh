# Load Ruby version management.
if command -v rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi

# Add Ruby gems to PATH.
if command -v ruby > /dev/null && command -v gem > /dev/null; then
    PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi