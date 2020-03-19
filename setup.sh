#!/bin/bash

DOT_FILES=(.vimrc .tmux.conf .config/flake8)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

