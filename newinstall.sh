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
        \n\n\t -h display this help message \
        \n\n core packages: \
        \n "$list" \
        \n\n"
  exit 1
}

sudo_check(){
  id -u | grep -w "^0" || check_fail=1
  if [[ "$check_fail" -eq 1 ]]; then
    printf "\n\n Must be run as sudo or root. Please try again. Exiting. \n\n"
    exit 1
  fi
}

input_check() { # check for flags

    echo "$1" | grep -i "e" && evolve=1
    echo "$1" | grep -i "r" && radio=1   && list+=" hamradio-all"
    echo "$1" | grep -i "g" && chrome=1  && list+=" google-chrome-stable"
    echo "$1" | grep -i "d" && discord=1 && list+=" discord"
    echo "$1" | grep -i "x" && xfce=1    && list+=" xfce4 xfce4-goodies xfwm4 xfce4-whiskermenu-plugin"
    echo "$1" | grep -i "h" && help=1    && usage

  #if [[ "$help" -eq 1 ]]; then
  #  usage
  #fi

  #if [[ "$radio" -eq 1 ]]; then
  #  list+=" hamradio-all"
  #fi

  #if [[ "$chrome" -eq 1 ]]; then
  #  list+=" google-chrome-stable"
  #fi

  #if [[ "$discord" -eq 1 ]]; then
  #  list+=" discord"
  #fi

  #if [[ "$xfce" -eq 1 ]]; then
  #  list+=" xfce4 xfce4-goodies xfwm4 xfce4-whiskermenu-plugin"
  #fi
}

maestro_evolve() { # Commands to install new drivers (make sure secure boot is disabled):
  sudo add-apt-repository ppa:kelebek333/kablosuz
  sudo apt-get update
  sudo apt-get install -y rtl8723du-dkms
  sudo reboot now
}

list="zsh nala terminator notepadqq tuxcmd doublecmd-gtk mc atop btop htop caffeine neofetch 7zip"

# main

sudo_check

input_check $@

sudo apt-get update

if [[ "$evolve" -eq 1 ]]; then
  maestro_evolve $@
else
  for package in $list; do
    sudo apt-get -y install $package
  done
fi
