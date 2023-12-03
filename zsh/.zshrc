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

alias srcros="source /opt/ros/humble/setup.zsh"
alias srccol="source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh"
alias srcrws="source /home/aei/repos/ros2_ws/install/setup.zsh"
alias srctb3="source /home/aei/repos/turtlebot3_ws/install/setup.zsh"

function ros() {
  srcros
  srccol
  srcrws
  srctb3
  complete -o nospace -o default -F _python_argcomplete "ros2"
  complete -o nospace -o default -F _python_argcomplete "colcon"
}

export ROS_DOMAIN_ID=30 #TURTLEBOT3
export TURTLEBOT3_MODEL=waffle_pi

source ~/.zplug/init.zsh

zplug "agkozak/zsh-z"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "MichaelAquilina/zsh-you-should-use"
zplug "jimhester/per-directory-history"
zplug "plugins/dirhistory", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh
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

alias explorer="/mnt/c/Windows/explorer.exe ."

[ -f "/home/aei/.ghcup/env" ] && source "/home/aei/.ghcup/env" # ghcup-env

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load #--verbose

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu yes select



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda/2023.09-0/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda/2023.09-0/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda/2023.09-0/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda/2023.09-0/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

