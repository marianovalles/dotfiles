#!/usr/bin/env bash

# Based on:
# https://github.com/sontek/dotfiles
# https://github.com/holman/dotfiles

info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

link_file() {
    source="${PWD}/$1"
    target="${HOME}/${1%.*}"

    if [ -e "${target}" ] && [ ! -L "${target}" ]; then
        mv $target $target.df.bak
    fi

    ln -sf ${source} ${target}
}

unlink_file() {
    source="${PWD}/$1"
    target="${HOME}/${1%.*}"

    if [ -e "${target}.df.bak" ] && [ -L "${target}" ]; then
        unlink ${target}
        mv $target.df.bak $target
    fi
}

setup_gitconfig() {
  if ! [ -f .gitconfig.symlink ]
  then
    info 'setup gitconfig'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential='osxkeychain'
    fi

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    sed -e "s/AUTHOR_NAME/$git_authorname/g" -e \
    "s/AUTHOR_EMAIL/$git_authoremail/g" -e \
    "s/GIT_CREDENTIAL_HELPER/$git_credential/g" .gitconfig.example > .gitconfig.symlink

    success 'gitconfig'
  fi
}

setup_ctags(){
  mkdir ~/.git_template/hooks
  cp ctags/ctags/* ~/.git_template/hooks/
  git config --global init.templatedir '~/.git_template'
}

setup_dotfiles(){
  if [ "$1" = "restore" ]; then
    for i in `find . -maxdepth 2 -name \*.symlink`
    do
      unlink_file `basename $i`
    done
    exit
  else
    for i in `find . -maxdepth 2 -name \*.symlink`
    do
      link_file `basename $i`
    done
  fi
}

setup_fonts(){
  if [ "$(uname -s)" == "Darwin" ]
  then
    cp .fonts/* ~/Library/Fonts
  fi
}

# Quick and dirty way of symlinking symlinks :P
setup_nvim(){
  mkdir ~/.config
  ln -s ~/.vim ~/.config/nvim
  ln -s ~/.vimrc ~/.config/nvim/init.vim
}

setup_homebrew(){
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

# Boostrap
setup_homebrew
setup_gitconfig
setup_fonts
setup_dotfiles $1
setup_ctags
setup_nvim
