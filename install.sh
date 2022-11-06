#!/bin/bash

SOURCES_LIST=./sources.list
VIMRC=./.vimrc
NVIMINIT=./init.vim

GIT_USER_NAME="wlonestar"
GIT_USER_EMAIL="wlonestar@163.com"

ZSHRC=./.zshrc

function change_source() {
  echo "[setup (1/5)] change apt source list"
  echo "[setup (1/5)] backup /etc/apt/sources.list to /etc/apt/sources.list.backup"
  sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
  sudo cp $SOURCES_LIST /etc/apt/sources.list
  echo "[setup (1/5)] update and upgrade"
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get autoremove -y
  echo "[setup (1/5)] finish!"
}

function install_utils() {
  echo "[setup (2/5)] install essential applications"
  sudo apt-get install vim neovim wget curl net-tools zsh \
    tree baobab python3-pip tmux -y
  echo "[setup (2/5)] finish!"
}

function config_neovim() {
  echo "[setup (3/5)] config vim and neovim"
  cp $VIMRC ~/
  mkdir -p ~/.config
  mkdir -p ~/.config/nvim
  cp $NVIMINIT ~/.config/nvim
  echo "[setup (3/5)] finish!"
}

function config_git() {
  echo "[setup (4/5)] config global git"
  git config --global credential.helper manager-core
  git config --global user.name $GIT_USER_NAME
  git config --global user.email $GIT_USER_EMAIL
  echo "[setup (4/5)] finish!"
}

function config_zsh() {
  echo "[setup (5/5)] config zsh with ohmyzsh"
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/ohmyzsh
  sh ~/ohmyzsh/tools/install.sh
  echo "[setup (5/5)] install zsh plugins"
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    ~/.oh-my-zsh/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
  cp $ZSHRC ~/.zshrc
  source ~/.zshrc
  echo "[setup (5/5)] finish!"
}

function extra() {
  echo "c/c++ env"
  sudo apt-get install build-essential gdb make cmake -y
  echo "java env"
  sudo wget \
    https://download.java.net/openjdk/jdk17/ri/openjdk-17+35_linux-x64_bin.tar.gz \
    -P /opt
  sudo mkdir /opt/openjdk17
  sudo tar xvf /opt/openjdk-17+35_linux-x64_bin.tar.gz -C /opt/openjdk17 --strip-components 1
  echo "export JAVA_HOME=/opt/openjdk17" >> ~/.zshrc
  echo "export PATH=$PATH:/$JAVA_HOME/bin" >> ~/.zshrc
  echo "python3 env"
  sudo apt-get install python3-pip
  echo "rust env"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

function main() {
  change_source
  install_utils
  config_neovim
  config_git
  config_zsh
  # extra
}

main

