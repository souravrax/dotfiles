call plug#begin(stdpath('data'))

" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline-themes'
Plug 'rafi/awesome-vim-colorschemes'
" Plug 'ervandew/supertab'

" Editor Plugins
" Plug 'Raimondi/delimitMate' " for opening and closing brackets
Plug 'jiangmiao/auto-pairs' " for opening and closing brackets
Plug 'chrisbra/vim-commentary' " commeting line/lines of code
" Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-sleuth'
"Plug 'SirVer/ultisnips'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'luochen1990/rainbow'
Plug 'editorconfig/editorconfig-vim'
Plug 'Chiel92/vim-autoformat'
Plug 'vimlab/split-term.vim'
Plug 'octol/vim-cpp-enhanced-highlight'

" Language specific
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
"Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'tikhomirov/vim-glsl'
Plug 'vhdirk/vim-cmake'
Plug 'ds26gte/scmindent'
Plug 'udalov/kotlin-vim'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" Plug 'jackguo380/vim-lsp-cxx-highlight'

if isdirectory("~/dev/mitscript-syntax")
  Plug '~/dev/mitscript-syntax'
endif

"Note taking
Plug 'vimwiki/vimwiki'
Plug 'lukaszkorecki/workflowish'

call plug#end()
syntax on
filetype plugin on
set encoding=utf-8

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
map g/ gcc
nnoremap <leader><space> za

:autocmd BufNewFile *.cpp 0r $HOME/.vim/templates/CPP/skeleton.cpp
:autocmd BufNewFile *.cpp exe "1," . 10 . "g/created:.*/s//created: " .strftime("%d.%m.%Y %H:%M:%S")
:autocmd BufNewfile *.cpp :104
:autocmd BufNewFile *.cc 0r $HOME/.vim/templates/CPP/skeleton.cc
:autocmd BufNewFile *.cc exe "1," . 10 . "g/created:.*/s//created: " .strftime("%d.%m.%Y %H:%M:%S")
:autocmd BufNewfile *.cc :14

:autocmd BufNewfile,BufRead *.cpp :!cp ~/.vim/clangd/compile_flags.txt .
:autocmd BufNewfile,BufRead *.cc :!cp ~/.vim/clangd/compile_flags.txt .

function! Judge()
    :let b:fileName = expand('%:t:r')
    :echo b:fileName
    :VTerm judge
endfunction

:autocmd filetype cpp nnoremap <F5> :w <bar> call Judge() <CR>
:autocmd filetype cpp nnoremap <F6> :w <bar> !%:r < in > out 2>err && cat out <CR>
:autocmd filetype cpp nnoremap <F8> :w <bar> !g++ -std=c++17 -Wshadow -Wall -DLOCAL -O2 % -o %:r -DLOCAL <CR>
:autocmd filetype cpp nnoremap <F9> :w <bar> !g++ -std=c++17 -Wshadow -Wall -Wno-unused-result % -o %:r -g -D_GLIBCXX_DEBUG -DLOCAL <CR>

highlight Comment cterm=italic gui=italic

set laststatus=2
" set showtabline=2

" true colours
" set background=dark
" set t_Co=256

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

colorscheme ayu
set number relativenumber
set splitbelow splitright
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
" set clipboard=unnamed " public copy/paste register
set ruler
set showcmd
set mouse=a " Set this to c to disable
set noswapfile " doesn't create swap files
set noshowmode
set foldmethod=syntax
set shortmess+=c
set softtabstop=4
set shiftwidth=4 
set tabstop=4 
set expandtab 
set fileformat=unix 
set autoindent " enable auto indentation of lines
set smartindent " allow vim to best-effort guess the indentation
set errorformat^=%-GIn\ file\ included\ %.%#
set cindent cinoptions=N-s,g0,j1,(s,m1
set undofile
" set omnifunc=syntaxcomplete#Complete
set autoread
set foldlevel=99
set ignorecase smartcase
set hidden
set nojoinspaces
set title
set updatetime=200 " Update gutters 200ms
set backspace=indent,eol,start " let backspace delete over lines
set pastetoggle=<F2> " enable paste mode
set wildmenu "graphical auto complete menu
set lazyredraw "redraws the screne when it needs to
set showmatch "highlights matching brackets
" set incsearch "search as characters are entered
" set hlsearch "highlights matching searches
let mapleader = "\\"

" =============== vim commentry config ===============
autocmd FileType cpp set commentstring=//\ %s " vim-commentry config for c++
" =============== vim commentry config end ===============


nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>
"clears highlights
nnoremap // :noh<return>
" moves current line down or up
vnoremap <leader>- ddp
vnoremap <leader>_ ddkP
" open vimrc in vertical split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" update changes into current buffer
nnoremap <leader>sv :source $MYVIMRC<cr>
" enable or disable line wrapping in current buffer
nnoremap <buffer> <localleader>w :set wrap!<cr>


" ============= Rainbow ================
let g:rainbow_active=1

" =========== Nerdtree config ================
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle NERDTree
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
" ============ Nerdtree config end ================

" ================= Integrated Terminal config =====================
" turn terminal to normal mode with escape
" tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
" au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
" function! OpenTerminal()
" split term://cmd
" resize 10
" endfunction
" nnoremap <c-n> :call OpenTerminal()<CR>
nnoremap <leader>t :VTerm<CR>
" ================= Integrated Terminal config end =====================

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" ============= delimitMate config ==================
let delimitMate_expand_cr = 1
autocmd FileType tex let b:delimitMate_autoclose = 0
" ============= delimitMate config end ==================

" Buffers a new file with name:in inside the current directory
command Input :vsplit in

let g:bufferline_rotate=1
let g:bufferline_fixed_index=-1
let g:bufferline_echo = 0

" ================ air-line =======================
let g:airline_powerline_fonts = 1
let g:airline_theme = 'jellybeans'
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
" ================ air-line end =======================


" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
