set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'fenetikm/falcon'
Plugin 'qpkorr/vim-bufkill'
Plugin 'itchyny/lightline.vim'
Plugin 'sheerun/vim-polyglot'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
syntax on
set termguicolors
set t_Co=256
colorscheme falcon 
set ts=4            " Tab width
set sw=4            " Shift width
set softtabstop=4   " If softtabstop equals tabstop and expandtab is not set,
                    " vim will always use tabs. When expandtab is set, vim will
                    " always use the appropriate number of spaces.
set smarttab        " Tab inserted when indenting and/or correct alignment spaces
set expandtab       " Use spaces when tab key is pressed
set textwidth=79    " Use 79 text width.
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

" statusline from vim cheat sheet for programmer "
set nocompatible ruler laststatus=2 showcmd showmode number

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
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab

" Arduino
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

let g:falcon_lightline = 1
let g:lightline={'colorscheme': 'falcon'}
