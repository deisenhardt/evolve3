#!/bin/bash

# functions

usage(){
  printf " Usage : newinstall.sh will install a set group of core packages to make desktop use more pleasant. \
        \n With the following flags, additional flags & packages can also be installed. \
        \n\n\t -e install the repo & wireless driver for the rtl8723du \
        \n\t -r install hamradio-all \
        \n\t -g install Google Chrome \
        \n\t -d install Discord \
        \n\t -x install XFCE & goodies \
        \n\n core packages: 
        \n "$word" \
        \n\n"
  exit 1
}

maestro_evolve() {
  # Commands to install new drivers (make sure secure boot is disabled):
  sudo add-apt-repository ppa:kelebek333/kablosuz
  sudo apt-get update
  sudo apt-get install -y rtl8723du-dkms
  sudo reboot now
}

input_check() {
  
  
  # check 2 words use word 1 for flags
  if [ $# -ge 1 ]; then
    echo "$1" | grep e && evolve=1
    echo "$1" | grep r && radio=1
    echo "$1" | grep g && chrome=1
    echo "$1" | grep d && discord=1
    echo "$1" | grep x && xfce=1
    echo "$1" | grep h && help=1
  fi

  if [ "$help" -eq 1 ]; then
    usage
  fi

  if [ "$radio" -eq 1 ]; then
    word+=" hamradio-all"
  fi

  if [ "$chrome" -eq 1 ]; then
    word+=" google-chrome-stable"
  fi

  if [ "$discord" -eq 1 ]; then
    word+=" discord"
  fi

  if [ "$xfce" -eq 1 ]; then
    word+=" xfce4 xfce4-goodiesxfwm4"
  fi
}

word="zsh nala terminator notepadqq tuxcmd doublecmd-gtk mc atop btop htop caffeine"

# main

input_check $@

sudo apt-get -y install "$word"

if "$evolve" -eq 1 ]; then
  maestro_evolve $@
fi
