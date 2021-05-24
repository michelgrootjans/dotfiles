#!/bin/sh

echo "Setting up your Mac..."

# Check for Oh My Zsh and install if we don't have it
if [ ! -d $HOME/.oh-my-zsh ]; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install git
if ! command -v git &> /dev/null; then
  brew install git
fi

# Clone to ~/.dotfiles
if [ ! -d $HOME/.dotfiles ]; then
  git clone git@github.com:michelgrootjans/dotfiles.git $HOME/.dotfiles
fi

# Install all our dependencies with bundle (See Brewfile)
brew update
brew tap homebrew/bundle
brew bundle --file ~/.dotfiles/Brewfile
brew cleanup

for file in .{zprofile,gitconfig,gitignore,nvm-init}; do
  # if file is symlink, delete it, else rename it to *.bak
  [ -L $HOME/$file ] && rm -rf $HOME/$file || mv $HOME/$file "$HOME/$file.bak"
  ln -s $HOME/.dotfiles/$file $HOME/$file
done;
unset file;


# Set macOS preferences - we will run this last because this will reload the shell
source .macos