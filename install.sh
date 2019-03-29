#!/bin/bash

DOTPATH=~/.dotfiles

for file_name in .??*
do
  [ "$file_name" = ".git" ] && continue

  ln -s -vi "$DOTPATH/$file_name" "$HOME/$file_name"
done

