# Created by newuser for 5.2

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# http://qiita.com/delphinus/items/b04752bb5b64e6cc4ea9
export LESS='-g -i -M -R -S -W -z-4 -x4'

PATH=/usr/local/bin:$PATH
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
#setopt share_history

fpath=(/path/to/homebrew/share/zsh-completions $fpath)
 
autoload -U compinit
compinit -u

# rbenv
eval "$(rbenv init - zsh)"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH


alias be="bundle exec"
alias giff="git diff --cached"


function findgrep() {
  find "$1" -type f -not -path '*/node_modules/*' -a -not -path '*/javascripts/packed/*' | xargs grep --color "$2"
}

function pero() {
  ack "$@" . | peco --exec 'awk -F : '"'"'{print "+" $2 " " $1}'"'"' | xargs less -N'
}

function who-use-port() {
  lsof -n -P -i ":$1"
}

# history search by peco
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# file search and open
function giv() {
  target_file=`git ls-files | peco`
  if [ -n "$target_file" ]; then
    echo "view $target_file"
    view $target_file
  fi
}

# git status
RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

