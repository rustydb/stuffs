set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'Erichain/vim-monokai-pro'
Plugin 'VundleVim/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'itspriddle/vim-shellcheck'
Plugin 'pylint.vim'
Plugin 'qpkorr/vim-bufkill'
Plugin 'scrooloose/nerdtree'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on
set t_Co=256
colorscheme monokai_pro
set ts=4            " Tab width
set sw=4            " Shift width
set softtabstop=4   " If softtabstop equals tabstop and expandtab is not set,
                    " vim will always use tabs. When expandtab is set, vim will
                    " always use the appropriate number of spaces.
set smarttab        " Tab inserted when indenting and/or correct alignment spaces
set expandtab       " Use spaces when tab key is pressed
set textwidth=0     " No text width.
set fileformat=unix
set autoindent
set cindent
set nosmartindent
set nocindent
set hid             " Hides unsaved changed buffers
set ruler           " Cursor location
set title           " Screen title updates to open buffer
set mouse=a         " Enables mouse use in all modes
set mousem=popup    " Enable pop up menu
set number          " Number lines
set cinkeys=0{,0},0),:,0%,!^F,o,O,e
au BufNewFile,BufRead *.html    set syntax=mason
au BufNewFile,BufRead *.comp    set syntax=mason
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" make search not suck "
set incsearch ignorecase smartcase hlsearch
hi IncSearch cterm=NONE ctermfg=yellow ctermbg=darkblue

" statusline from vim cheat sheet for programmer "
set nocompatible ruler laststatus=2 showcmd showmode number modeline

let fortran_free_source=1
let fortran_have_tabs=1
let fortran_more_precise=1
let fortran_do_enddo=1

let g:miniBufExplMapWindowNavVim=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplModSelTargelt=1

" Binds ctrl-del delete a word in insert
imap <C-kDel> <C-O>caw

" starts nerd tree and sets cursor to main window
autocmd VimEnter * wincmd p

" Shortcut to toggle NERDTree
nmap <F3> :NERDTreeToggle<CR>

" Easier split navigation
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Spacing to 2 for YAML
autocmd FileType yaml setlocal ts=4 sts=0 sw=2 et ai
autocmd FileType yml setlocal ts=4 sts=0 sw=2 et ai

" Arduino
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

