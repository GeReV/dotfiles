#Load themes from yadr and from user's custom prompts (themes) in ~/.zsh.prompts
autoload promptinit
fpath=($DOTFILES/source/zsh/prezto-themes $DOTFILES/vendor/prezto/modules/prompt/functions $HOME/.zsh.prompts $fpath)
promptinit
