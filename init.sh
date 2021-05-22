#!/bin/sh

# Check for Oh My Zsh and install if we don't have it
if [ ! -d ~/.oh-my-zsh ]; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install git, clone ~/.dotfiles and run install.sh
if ! command -v git &> /dev/null; then
  brew install git
fi

if [ ! -d ~/.dotfiles ]; then
  git clone git@github.com:michelgrootjans/dotfiles.git ~/.dotfiles
fi
#~/.dotfiles/install.sh