Heavily inspired by https://dotfiles.github.io/ and https://github.com/driesvints/dotfiles

# Steps to setup a new machine:

## Start a brand new installation:
This will run the installation on a brand new machine
- `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/michelgrootjans/dotfiles/HEAD/init.sh)"`

## Refresh an existing installation:
- `~/.dotfiles/init.sh`


# Homebrew

## Apply existing Brewfile
`brew bundle`

## Update Brewfile based on current system
`brew bundle dump --force`
