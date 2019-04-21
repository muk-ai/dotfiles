#!/bin/bash

DOTPATH=~/.dotfiles
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

# Visual Studio Code
if [ "$OS" = 'Mac' ]; then
  ln -s -vi "$DOTPATH/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
  ln -s -vi "$DOTPATH/vscode/locale.json" "$HOME/Library/Application Support/Code/User/locale.json"
  ln -s -vi "$DOTPATH/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"
fi

# from `code --list-extensions`
vscode_extensions=(
castwide.solargraph
christian-kohler.path-intellisense
CoenraadS.bracket-pair-colorizer
donjayamanne.githistory
eamodio.gitlens
esbenp.prettier-vscode
GitHub.vscode-pull-request-github
johnpapa.Angular2
Kasik96.swift
Kelvin.vscode-sshfs
misogi.ruby-rubocop
MS-CEINTL.vscode-language-pack-ja
ms-python.python
rebornix.ruby
ryu1kn.partial-diff
sianglim.slim
vscodevim.vim
wayou.vscode-todo-highlight
wmaurer.change-case
)
for extension_name in ${vscode_extensions[@]}; do
  code --install-extension $extension_name
done

