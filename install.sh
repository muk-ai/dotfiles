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

mkdir -p ${HOME}/.zsh/completions
curl -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o "${HOME}/.zsh/completions/git-completion.bash"
curl -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh -o "${HOME}/.zsh/completions/_git"

# Visual Studio Code
if [ "$OS" = 'Mac' ]; then
  ln -s -vi "$DOTPATH/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
  ln -s -vi "$DOTPATH/vscode/locale.json" "$HOME/Library/Application Support/Code/User/locale.json"
  ln -s -vi "$DOTPATH/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"

  # from `code --list-extensions`
  vscode_extensions=(
    castwide.solargraph
    christian-kohler.path-intellisense
    CoenraadS.bracket-pair-colorizer-2
    donjayamanne.githistory
    eamodio.gitlens
    esbenp.prettier-vscode
    GitHub.vscode-pull-request-github
    Kasik96.swift
    misogi.ruby-rubocop
    MS-CEINTL.vscode-language-pack-ja
    ms-python.python
    rebornix.ruby
    ryu1kn.partial-diff
    vscodevim.vim
    wayou.vscode-todo-highlight
    wmaurer.change-case
    angular.ng-template
    dbaeumer.vscode-eslint
    chrmarti.regex
    rust-lang.rust
    visualstudioexptteam.vscodeintellicode
  )
  for extension_name in ${vscode_extensions[@]}; do
    code --install-extension $extension_name
  done
fi

