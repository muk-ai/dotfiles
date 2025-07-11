# Created by newuser for 5.2

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# http://qiita.com/delphinus/items/b04752bb5b64e6cc4ea9
export LESS='-g -i -M -R -S -W -z-4 -x4'

PATH=/usr/local/bin:$PATH
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups     # ignore duplication command history list
# setopt share_history

fpath=(${HOME}/.zsh/completions $fpath)
 
autoload -U compinit
compinit -u

# rbenv
eval "$(rbenv init - zsh)"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH


alias be="bundle exec"


function findgrep() {
  find "$1" -type f -not -path '*/node_modules/*' -a -not -path '*/javascripts/packed/*' | xargs grep --color "$2"
}

function who-use-port() {
  lsof -n -P -i ":$1"
}

function history-fzf() {
  #BUFFER=$(history -n -r 1 | fzf --reverse --no-sort --query "$LBUFFER" --prompt="history | fzf > ")
  BUFFER=$(history -n -r 1 | fzf --reverse --query "$LBUFFER" --prompt="history | fzf > ")
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N history-fzf
bindkey '^R' history-fzf

# file search and open
function giv() {
  target_file=`git ls-files | fzf`
  if [ -n "$target_file" ]; then
    echo "view $target_file"
    view $target_file
  fi
}

function tm() {
  local new_session_option="[new]"
  local session_list
  session_list=$(tmux ls 2>/dev/null)

  local choice
  choice=$( (echo "$new_session_option"; echo "$session_list") | fzf --header="Select a session or create a new one" )

  if [[ -z "$choice" ]]; then
    echo "Cancelled."
    return 0
  fi

  if [[ "$choice" == "$new_session_option" ]]; then
    tmux new-session
  else
    local session_name=${choice%%:*}
    tmux new-session -A -s "$session_name"
  fi
}

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

PROMPT='
git ${vcs_info_msg_0_}
[%n@%m]
${PWD}
%(!.#.$) '

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='--height 60% --reverse --border'

alias gd='cd $(ghq root)/$(ghq list | fzf --no-multi)'
alias cdtemp='cd $(mktemp -d)'

# rust
export PATH="$HOME/.cargo/bin:$PATH"

