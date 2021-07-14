#!/bin/sh

set -e

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  UNAME_MACHINE="$(/usr/bin/uname -m)"

  if [[ "$UNAME_MACHINE" == "arm64" ]]; then
    # On ARM macOS, homebrew installs to /opt/homebrew only
    echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> $HOME/.zprofile_local
    eval $(/opt/homebrew/bin/brew shellenv)
  else
    # On Intel macOS, homebrew installs to /usr/local only
    eval $(/usr/local/bin/brew shellenv)
  fi
fi

# Install git
if ! command -v git &> /dev/null; then
  brew install git
fi

# Clone to ~/.dotfiles
DOTFILES=$HOME/.dotfiles
# DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

if [ ! -d $DOTFILES ]; then
  git clone https://github.com/michelgrootjans/dotfiles.git $DOTFILES
fi

source $DOTFILES/install/.software
source $DOTFILES/install/.shell
source $DOTFILES/install/.dotfiles
source $DOTFILES/install/.customize

# Set macOS preferences - we will run this last because this will reload the shell
source $DOTFILES/install/.macos