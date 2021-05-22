#!/bin/sh

echo "Setting up your Mac..."

# Check for Oh My Zsh and install if we don't have it
if [ ! -d ~/.oh-my-zsh ]; then
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
if [ ! -d ~/.dotfiles ]; then
  git clone git@github.com:michelgrootjans/dotfiles.git ~/.dotfiles
fi

# Install all our dependencies with bundle (See Brewfile)
brew update
brew tap homebrew/bundle
brew bundle --file ~/.dotfiles/Brewfile
brew cleanup

rm -rf $HOME/.zprofile
ln -s $HOME/.dotfiles/.zprofile $HOME/.zprofile