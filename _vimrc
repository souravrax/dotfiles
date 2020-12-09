" set pythonthreedll=C:\Users\Sourav\AppData\Local\Programs\Python\Python38-32\python38.dll
" set pythonhome=C:\Users\Sourav\AppData\Local\Programs\Python\Python38-32
" ======================================
" Welcome to Sourav Rakshit's vimrc file
" ======================================
set nocompatible  "be iMproved, required
set exrc

set encoding=UTF-8

set rtp+=$HOME/.vim/bundle/Vundle.vim

call vundle#begin('$HOME/.vim/bundle/')
" ==== PLUGINS ====

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/L9'
Plugin 'tpope/vim-fugitive'
Plugin 'rstacruz/sparkup', {'rtp':'vim'}
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-commentary'
Plugin 'bogado/file-line'
Plugin 'frazrepo/vim-rainbow'

" ==== THEMES ====
Plugin 'morhetz/gruvbox'
Plugin 'tomasr/molokai'
Plugin 'joshdick/onedark.vim'
Plugin 'hzchirs/vim-material'
" ==== END PLUGINS ====

call vundle#end()


" filetype plugin indent on
" au FileType c,cpp,objc,objcpp call rainbow#load()

" ====== TEMPLATE SETTINGS =======
:autocmd BufNewFile *.cpp 0r $HOME/.vim/templates/CPP/skeleton.cpp
:autocmd BufNewFile *.cpp exe "1," . 10 . "g/created:.*/s//created: " .strftime("%d.%m.%Y %H:%M:%S")
:autocmd BufNewfile *.cpp :83
:autocmd BufNewFile *.cc 0r $HOME/.vim/templates/CPP/skeleton.cc
:autocmd BufNewFile *.cc exe "1," . 10 . "g/created:.*/s//created: " .strftime("%d.%m.%Y %H:%M:%S")
:autocmd filetype cpp nnoremap <F4> :w <bar> !g++ -ulimit -Wall -Wshadow -Wno-unused-result -std=c++17 -DLOCAL -O2 % -o %:r && wt -p "Command Prompt"<CR>
:autocmd filetype cpp nnoremap <F5> :w <bar> !g++ -ulimit -Wall -Wshadow -Wno-unused-result -std=c++17 -DLOCAL -O2 % -o %:r && %:r <CR>
:autocmd filetype cpp nnoremap <F6> :w <bar> !g++ -ulimit -Wall -Wshadow -Wno-unused-result -std=c++17 -DLOCAL -O2 % -o %:r && %:r.exe < in.txt > out.txt 2>&1 && cat out.txt <CR>

" ===== TEMPLATE SETTINGS END =====

" ==== FONT SETTINGS ====
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Consolas\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h12
  elseif has("gui_win32")
    set guifont=Cascadia\ Code:h10
  endif
endif

" ==== FONT SETTINGS END =====

" ===== WSL SETTINGS ======
" if has("win32")
"     set shell=wt
"     set shellpipe=|
"     set shellredir=>
"     set shellcmdflag=
" endif
" ===== WSL SETTINGS END =====

" ==== KEYMAPPING =====

inore <C-k> <Esc>
nnore %ya gg"*yG
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
nnoremap <Tab> >>
nnoremap <F10> :!wt -p "PowerShell" <CR>

" ==== KEYMAPPING END ====

" ==== GENERAL SETTINGS =====

set fillchars+=vert:\|
syntax on
set ruler
set mouse=a " set the value to c to disable
set hidden
set autoindent
set number
set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
set laststatus=2
set nowrap
set smartindent
set st=4 sw=4 et
set shiftwidth=4
set ff=unix
set backspace=indent,eol,start
set tabstop=4
set colorcolumn=80
set laststatus=2
" colo molokai
set autoread
set statusline=WelcomeToVim!
highlight Comment guifg=#A9A9A9
:set foldmethod=syntax
:set ffs=unix
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
" :set guioptions-=L  "remove left-hand scroll bar
:set lines=999 columns=999
" let g:ycm_path_to_python_interpreter="C:/Users/Sourav/AppData/Local/Programs/Python/Python38-32/python.exe"

:set nocp
filetype plugin on

" ==== GENERAL SETTINGS END =====
"
" ==== Airline Settings =====
" let g:airline_theme='material'
