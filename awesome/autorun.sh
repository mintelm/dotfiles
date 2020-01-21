#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run compton --vsync --config ~/.config/compton.conf
run nm-applet
run slack -u
run optimus-manager-qt
