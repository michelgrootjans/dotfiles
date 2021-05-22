# Compatible with server configs
export LC_ALL="en_US.UTF-8"
export LANG="en_US"
export TZ=CET

# setup Python pyenv
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# CLI customisation
alias ls='exa' # see https://github.com/ogham/exa
alias cat='bat'
alias top=bpytop
alias diff=icdiff

mkcd() { mkdir -p "$@" && cd "$@"; }
autoload -U compinit
compinit

if [ -f ~/.zprofile_local ]; then
    source ~/.zprofile_local
fi