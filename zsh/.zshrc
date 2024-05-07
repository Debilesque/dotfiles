
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jellu/.zshrc'

alias kllx="killall xcape"
alias ip="ip -c"

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

export PATH="$HOME/.local/bin:$PATH"
eval "$(starship init zsh)"
