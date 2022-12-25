# Compatible with server configs
export LC_ALL="en_US.UTF-8"
export LANG="en_US"
export TZ=CET

# CLI customisation
alias ls='exa' # see https://github.com/ogham/exa
alias cat='bat'
alias top=btop
alias diff=icdiff
alias kraken='open -na "GitKraken" --args -p $(pwd)'

mkcd() { mkdir -p "$@" && cd "$@"; }
gitall() { find . -type d -depth 1 -print -exec git -C {} "$@"  \; }
mob-start() { git checkout -b "$@" && git push origin "$@" -u && mob start -i; }

autoload -U compinit
compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ ! -f ~/.zprofile_local ]] || source ~/.zprofile_local

source $HOME/.dotfiles/dev/.all

. /opt/homebrew/opt/asdf/libexec/asdf.sh