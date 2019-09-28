#!/bin/bash

command_exists() {
    type "$1" > /dev/null 2>&1
}

echo "Installing dotfiles."

echo "Initializing submodule(s)"
git submodule update --init --recursive

source ~/dotfiles/install/link.sh
source ~/dotfiles/install/setup.sh
source ~/dotfiles/install/git_config.sh


#echo "creating vim directories"
#mkdir -p ~/.vim-tmp
mkdir -p ~/.scripts/

echo "Done. Reload your terminal."
