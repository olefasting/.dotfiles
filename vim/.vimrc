call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-markdown'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'edkolev/tmuxline.vim'
Plug 'majutsushi/tagbar'
Plug 'jlanzarotta/bufexplorer'
Plug 'Shougo/vimshell.vim'
Plug 'artnez/vim-wipeout'
Plug 'scrooloose/syntastic'
Plug 'vim-scripts/armasm'
Plug 'racer-rust/vim-racer'
Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'

call plug#end()

set number
set encoding=utf-8
set t_Co=256
syntax on
filetype plugin on

set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11

" Undo tree
if has("persistent_undo")
  set undodir=~/.undodir/
  set undofile
endif


let syntastic_stl_format = '[Syntax: %E{line:%fe }%W{#W:%w}%B{ }%E{#E:%e}]'

" Nerdtree settings
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 30
let g:NERDTreeMinimalUI = 1

" Explorer mappings
nnoremap <f1> :BufExplorer<cr>
nnoremap <f2> :NERDTreeToggle<cr>
nnoremap <f3> :TagbarToggle<cr>
nnoremap <f4> :NERDTreeFind<cr>
nnoremap <f5> :e %:h<cr>
nnoremap <c-f> :CtrlP<cr>
nnoremap <c-b> :CtrlPBuffer<cr>
nnoremap <C-u> :UndotreeToggle<CR>

" Open NERDTree if vim is started with no file open
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if NERDTree is only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Arrows wont show on many platform
"let g:NERDTreeDirArrowExpandable = '+'
"let g:NERDTreeDirArrowCollapsible = '-'

" Easyalign bindings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Disable auto comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Toggle auto indent on paste
" set pastetoggle=<F2>
nnoremap <F6> :set invpaste paste?<CR>
set pastetoggle=<F6>
set showmode

" Status line
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:tmuxline_preset = 'tmux'
let g:airline_powerline_fonts = 1

set laststatus=2

" Display warning if file format is not for unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

" Display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

" Airline theme
let g:airline_theme='molokai'

" Show hidden files
let NERDTreeShowHidden=1

nmap <F8> :TagbarToggle<CR>

" Language support

" CLANG
let g:clang_library_path='/usr/lib/clang/3.8.1/lib'

" Rust / Racer
set hidden
let g:racer_cmd = "/usr/bin/racer"
let $RUST_SRC_PATH="/usr/src/rust/src/"

