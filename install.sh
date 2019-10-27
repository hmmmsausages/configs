#!/bin/sh

set -e

xcode-select -p > /dev/null 2>&1
if [ $? != 0 ]; then
  echo "Installing xCode Command Line Developer Tools"
  xcode-select --install
fi

if [ $SHELL != "/bin/zsh" ]; then
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  echo "Installing Powerline Fonts"
  git clone https://github.com/powerline/fonts
  popd fonts
  ./install.sh
  pushd
  rm -rf fonts

  echo "Installing Powerlevel9k Theme"
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
  echo "Copying .zshrc ZSH Profile"
  mv .zshrc ~
fi

if ! command -v brew > /dev/null 2>&1 ; then
  echo "Installing Homebew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing any missing apps"
brew bundle

set +e
