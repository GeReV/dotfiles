# Prezto

# Link all Prezto .z-files to the home directory, except zpretorc, which we override.
for rcfile in $DOTFILES/link/.zprezto/runcoms/z*; do
    filename=${rcfile##*/}

    if [[ $filename != "zpreztorc" ]]; then
        ln -nfs "$rcfile" "$HOME/.$filename"
    fi;
done

# Add the following line to .zshrc so custom configuration is ran for zsh.
echo "" >> $HOME/.zshrc
echo "for config_file ($DOTFILES/source/zsh/*.zsh) source \$config_file" >> $HOME/.zshrc
echo "" >> $HOME/.zshrc
echo "DOTFILES=$DOTFILES" >> $HOME/.zshrc
echo "for config_file ($DOTFILES/source/*.sh) source \$config_file" >> $HOME/.zshrc

# Create override directories.
mkdir -p $HOME/.zsh.before
mkdir -p $HOME/.zsh.after
mkdir -p $HOME/.zsh.prompts
