eval "$(starship init zsh)"

eval $(thefuck --alias fuck)

export HISTSIZE=30000
export SAVEHIST=30000
export HISTFILE=~/.zsh_history
export HISTTIMEFORMAT="[%F %T] "
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

alias cls="clear"

alias vim="nvim"

alias ls="exa --icons --group-directories-first"
alias ll="exa --icons --group-directories-first --long --all"
alias la="exa --icons --group-directories-first --long --tree"
alias dir="exa --icons --only-dirs --all"

alias grep='grep --color'

source "/usr/local/share/goto.sh"

alias g="goto"

alias srczsh="source ~/.zshrc"

source ~/.zplug/init.zsh

zplug "agkozak/zsh-z"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "MichaelAquilina/zsh-you-should-use"
zplug "jimhester/per-directory-history"
zplug "plugins/dirhistory", from:oh-my-zsh
zplug "zpm-zsh/material-colors"
zplug "trapd00r/LS_COLORS"

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

alias here="goto --push $(pwd)"
alias there="goto --pop"

alias h='history'
alias hs='history | grep'
alias hsi='history | grep -i'

c () {
  [ -d ./bin ] || mkdir bin
  g++ "$1" -o ./bin/"${1%.*}" && ./bin/"${1%.*}"
}

alias lg="lazygit"
alias py="python3"
alias fetch="neofetch"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load #--verbose
