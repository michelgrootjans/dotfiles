#!/bin/sh

set -e

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  UNAME_MACHINE="$(/usr/bin/uname -m)"

  if [[ "$UNAME_MACHINE" == "arm64" ]]; then
    # On ARM macOS, this script installs to /opt/homebrew only
    HOMEBREW_PREFIX="/opt/homebrew"
    echo 'eval "\$(${HOMEBREW_PREFIX}/bin/brew shellenv)"' >> $HOME/.zprofile_local
  else
    # On Intel macOS, this script installs to /usr/local only
    HOMEBREW_PREFIX="/usr/local"
  fi

  eval "\$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
fi

# Install git
if ! command -v git &> /dev/null; then
  brew install git
fi

# Clone to ~/.dotfiles
if [ ! -d $HOME/.dotfiles ]; then
  git clone https://github.com/michelgrootjans/dotfiles.git $HOME/.dotfiles
fi


# Install all our dependencies with bundle (See Brewfile)
brew update
brew tap homebrew/bundle
brew bundle --file ~/.dotfiles/Brewfile
brew cleanup

# Check for Oh My Zsh and install if we don't have it
if [ ! -d $HOME/.oh-my-zsh ]; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for powerlevel10k and install if we don't have it
if [ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
else
  git -C $HOME/.oh-my-zsh/custom/themes/powerlevel10k pull
fi

# Install sdkman
if ! command -v sdk &> /dev/null; then
  curl -s "https://get.sdkman.io" | bash
fi

for file in .{zshrc,zprofile,gitconfig,gitignore,nvm-init,p10k.zsh}; do
  # if file is symlink, delete it, else rename it to *.bak
  [ -f $HOME/$file ] && mv $HOME/$file "$HOME/$file.bak"
  ln -sf $HOME/.dotfiles/$file $HOME/$file
done;
unset file;

# Install krisp
# sudo softwareupdate --install-rosetta
# brew install --cask krisp

# Set macOS preferences - we will run this last because this will reload the shell
source .macos