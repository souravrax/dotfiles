" ==================================================
" Welcome to Sourav Rakshit's vimrc file (LF)(LINUX)
" ==================================================

" ========= PREREQUESTICS =========
" Vundle installed in ~/.vim/bundle/
" ==================================


set nocompatible  "be iMproved, required
set exrc

set encoding=UTF-8

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" ==== PLUGINS ====

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/L9'
Plugin 'tpope/vim-fugitive'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'scrooloose/nerdtree'
Plugin 'joshdick/onedark.vim'
" Plugin 'ycm-core/YouCompleteMe'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-commentary'
" Plugin 'scrooloose/syntastic'
Plugin 'christoomey/vim-conflicted'
Plugin 'jacoborus/tender.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'mattn/emmet-vim'
Plugin 'sjl/gundo.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'itchyny/lightline.vim'

" ==== PLUGIN THEMES ====

Plugin 'vim-scripts/darktango.vim'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'morhetz/gruvbox'
Plugin 'tomasr/molokai'

" ==== END PLUGIN THEMES ====

" ==== PLUGIN SYNTAXES ====
Plugin 'mitsuhiko/vim-jinja'
Plugin 'hdima/python-syntax'
" ==== END PLUGIN SYNTAXES ====


" ==== END PLUGINS ====

call vundle#end()


filetype plugin indent on


" ====== TEMPLATE SETTINGS =======
:autocmd BufNewFile *.sm.cpp 0r $HOME/.vim/templates/CPP/skeleton.sm.cpp
:autocmd BufNewFile *.cpp 0r $HOME/.vim/templates/CPP/skeleton.cpp
:autocmd BufNewFile *.perf.cpp 0r $HOME/.vim/templates/CPP/skeleton.perf.cpp
:autocmd filetype cpp nnoremap <F5> :w <bar> !g++ -ulimit -Wall -Wno-unused-result -std=c++11 -DLOCAL   -O2   % -o %:r && %:r <CR>
:autocmd filetype cpp nnoremap <F6> :w <bar> !g++ -ulimit -Wall -Wno-unused-result -std=c++11 -DLOCAL   -O2   % -o %:r && %:r.exe < in <CR>
" ===== TEMPLATE SETTINGS END =====

" ==== FONT SETTINGS ====
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Consolas\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h12
  elseif has("gui_win32")
    set guifont=Cascadia\ Code:h9:cANSI
  endif
endif

" ==== FONT SETTINGS END =====


" ==== KEYMAPPING =====

inore <C-k> <Esc>
nnore %ya gg"*yG
nnoremap "ss "*p

" ==== KEYMAPPING END ====

" ==== GENERAL SETTINGS =====

set fillchars+=vert:\|
syntax on
" set background=dark
set ruler
" colo default
set mouse=a " set the value to c to disable
set relativenumber
set hidden
set number
set laststatus=2
set nowrap
set smartindent
set st=4 sw=4 et
set shiftwidth=4
set backspace=indent,eol,start
set tabstop=4
let g:vim_json_syntax_conceal = 0
" set colorcolumn=80
set laststatus=2
set autoread
set statusline=WelcomeToVim!
" :set guioptions-=m  "remove menu bar
" :set guioptions-=T  "remove toolbar
" :set guioptions-=r  "remove right-hand scroll bar
" :set guioptions-=L  "remove left-hand scroll bar
:set lines=999 columns=999



" ==== GENERAL SETTINGS END =====

" ====== LIGHTLINE SETTINGS =========
let g:lightline = { 'colorscheme': 'default' }


" ========= LIGHTLINE SETTINGS END =========


" ==== NERDTREE
let NERDTreeIgnore = ['__pycache__', '\.pyc$', '\.o$', '\.so$', '\.a$', '\.swp', '*\.swp', '\.swo', '\.swn', '\.swh', '\.swm', '\.swl', '\.swk', '\.sw*$', '[a-zA-Z]*egg[a-zA-Z]*', '.DS_Store']

let NERDTreeShowHidden=1
let g:NERDTreeWinPos="left"
let g:NERDTreeDirArrows=0
map <C-t> :NERDTreeToggle<CR>

" ==== Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_mri_args = "--config=$HOME/.jshintrc"
let g:syntastic_python_checkers = [ 'pylint', 'flake8', 'python' ]
let g:syntastic_yaml_checkers = ['jsyaml']
let g:syntastic_html_tidy_exec = 'tidy5'
let g:syntastic_python_flake8_config_file='.flake8'

" === flake8
let g:flake8_show_in_file=1

" ==== snippets
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_semantic_triggers =  { 'c' : ['->', '.', '::', 're!gl'], 'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s'] }
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" ==== Easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap f <Plug>(easymotion-s)

" ==== moving around
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" ==== disable swap file warning
set shortmess+=A

" === generate ctags
" echo "generating tags..."
" call system('ctags -R . ')

let g:pymode_indent = 0
" ==== custom commands
command JsonPretty execute ":%!python -m json.tool"
set secure