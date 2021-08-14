#!/bin/bash 

light_theme=$(alacritty-colorscheme status | grep "light")
echo $light_theme
if [ $light_theme ]; then
  alacritty-colorscheme apply base16-gruvbox-dark-hard-256.yml
  sed -ie 's/background=light/background=dark/g' ~/.dotfiles/nvim/init.vim 
else
  alacritty-colorscheme apply base16-gruvbox-light-hard-256.yml
  sed -ie 's/background=dark/background=light/g' ~/.dotfiles/nvim/init.vim 
fi
