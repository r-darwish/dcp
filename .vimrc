set nocompatible
syntax on

set wildmode=longest,list,full
set wildmenu
set hidden
set incsearch
set gdefault
set backspace=indent,eol,start
set ignorecase
set background=dark
set expandtab
set tabstop=4
set shiftwidth=4

autocmd BufEnter * silent! lcd %:p:h

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'chrisbra/SudoEdit.vim'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'Matt-Deacalion/vim-systemd-syntax'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

:noremap <C-b> :CtrlPBuffer<CR>
:noremap <C-y> :CtrlPMRU<CR>

let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-u>'
let g:multi_cursor_skip_key='<C-k>'
let g:multi_cursor_quit_key='<Esc>'

set t_Co=256
colorscheme jellybeans
set laststatus=2
set number
nnoremap Q <nop>

nmap s <Plug>(easymotion-s)
omap s <Plug>(easymotion-s)
xmap s <Plug>(easymotion-s)
imap fd <Esc>

set ignorecase smartcase
command W SudoWrite
