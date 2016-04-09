# Prezto

# Link all Prezto .z-files to the home directory, except zpretorc, which we override.
for $config_file ($DOTFILES/.zprezto/runcoms/z*); do
    filename = ${config_file##*/}

    if [[ $filename !== "zpreztorc") ]]; then
        ln -nfs "$config_file" "$HOME/.$filename"
    fi;
done

# Add the following line to .zshrc so custom configuration is ran for zsh.
echo "" >> $HOME/.zshrc
echo "for config_file ($DOTFILES/source/zsh/*.zsh) source $config_file" >> $HOME/.zshrc

# Create override directories.
mkdir -p $HOME/.zsh.before
mkdir -p $HOME/.zsh.after
mkdir -p $HOME/.zsh.prompts
