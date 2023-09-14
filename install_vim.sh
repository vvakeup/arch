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
set noundofile
set updatetime=300                                                          
set signcolumn=yes  
set set nocompatible

call plug#begin('$VIM/vimfiles/plugged')
" Plug 'junegunn/vim-easy-align'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'sainnhe/everforest'
call plug#end()

 " Important!!
if has('termguicolors')
  set termguicolors
endif
" For dark version.
set background=dark
" Set contrast.
" This configuration option should be placed before `colorscheme everforest`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'medium'
let g:everforest_better_performance = 1
let g:everforest_enable_italic = 1
let g:everforest_diagnostic_line_highlight = 1
let g:everforest_cursor = 'orange'
colorscheme everforest

EOF

echo "Vim install finished!"
