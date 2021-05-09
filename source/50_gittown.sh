if [[ "$(type -p git-town)" ]]; then
	# Load git-town completions
	eval "$(git-town completions zsh)"
fi
