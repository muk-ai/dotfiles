#!/bin/bash

DOTPATH=~/dotfiles
if [ "$(uname)" = 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
  OS='Linux'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

for file_name in .??*
do
  [ "$file_name" = ".git" ] && continue

  ln -s -vi "$DOTPATH/$file_name" "$HOME/$file_name"
done

if [ "$OS" = 'Linux' ]; then
  mkdir -p -m 700 "${HOME}/.ssh"
  if [ ! -e "${HOME}/.ssh/rc" ]; then
    ln -s -v "$DOTPATH/ssh/rc" "${HOME}/.ssh/rc"
  fi
fi

mkdir -p ${HOME}/.zsh/completions
curl -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o "${HOME}/.zsh/completions/git-completion.bash"
curl -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh -o "${HOME}/.zsh/completions/_git"

