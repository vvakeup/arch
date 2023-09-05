#!/bin/sh
#Vim-Plug:
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#Node:
sudo pacman -S npm && \
sudo npm cache clean -f && \
sudo npm install -g n && \
sudo n stable && \
hash -r

#Coc-Vim:
cat <<EOF >> ~/.vimrc
set number                                                                  
set ruler                                                                   
set tabstop=4                                                               
set shiftwidth=4                                                            
set autoindent                                                              
set clipboard=unnamed                                                       
set textwidth=75                                                            
set term=xterm-256color                                                     
set colorcolumn=+1                                                          
set encoding=utf-8                                                          
set nobackup                                                                
set nowritebackup                                                           
set noswapfile                                                              
set updatetime=300                                                          
set signcolumn=yes  

call plug#begin()
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
EOF

echo "Vim install finished!"
