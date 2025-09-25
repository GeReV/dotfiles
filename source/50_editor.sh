# Editing

export VISUAL=vim

# If mvim is installed, use it instead of native vim
if ! command -v nvim &> /dev/null; then
    VISUAL="nvim"
    alias vim="$VISUAL"
fi

if [[ ! "$SSH_TTY" ]]; then
  if [[ ! "$TMUX" ]]; then
    is_osx && VISUAL=nvim || VISUAL=gvim
  fi
  export LESSEDIT="$VISUAL ?lm+%lm -- %f"
  export GIT_EDITOR="$VISUAL -f"
fi

export EDITOR="$VISUAL"

# VS Code
if ! command -v code &> /dev/null; then
  EDITOR="code --wait"
  VISUAL="code --wait --new-window"
  unset GIT_EDITOR
fi

function q() {
  if [[ -t 0 ]]; then
    $VISUAL "$@"
  else
    # Read from STDIN (and hide the annoying "Reading from stdin..." message)
    $VISUAL - > /dev/null
  fi
}
alias qv="q $DOTFILES/link/.{,g}vimrc +'cd $DOTFILES'"
alias qs="q $DOTFILES"

# For when you have vim on the brain
alias :q=exit
