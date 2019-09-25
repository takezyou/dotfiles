#!/bin/bash

# dotfiles dir
DIR=`pwd`

# setup vimrc
ln -s $DIR/vim/*.toml $HOME/.vim
ln -s $DIR/vim/vimrc $HOME/.vimrc
