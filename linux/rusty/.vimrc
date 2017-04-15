set ts=4            " Tab width
set sw=4            " Shift width
set softtabstop=4   " If softtabstop equals tabstop and expandtab is not set,
                    " vim will always use tabs. When expandtab is set, vim will
                    " always use the appropriate number of spaces.
set smarttab        " Tab inserted when indenting and/or correct alignment spaces
set expandtab       " Use spaces when tab key is pressed
set autoindent
set cindent
set nosmartindent
set nocindent
filetype plugin indent on
set hid             " Hides unsaved changed buffers
set ruler           " Cursor location
set title           " Screen title updates to open buffer
set mouse=a         " Enables mouse use in all modes
set mousem=popup    " Enable pop up menu
set number          " Number lines
set t_Co=256        " Sets vim to 256 colors
set cinkeys=0{,0},0),:,0%,!^F,o,O,e
au BufNewFile,BufRead *.html    set syntax=mason
au BufNewFile,BufRead *.comp    set syntax=mason
"au BufNewFile,BufRead cf.*      set syntax=cfengine
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+ze\t/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
set background=dark
colorscheme molokai         " Love, edited comment color to lightslategray
syntax enable               " Syntax highlighting
filetype plugin indent on   " Detection of such
" make search not suck "
set incsearch ignorecase smartcase hlsearch
" statusline from vim cheat sheet for programmer "
set nocompatible ruler laststatus=2 showcmd showmode number
" Let fortran be
let fortran_free_source=1
let fortran_have_tabs=1
let fortran_more_precise=1
let fortran_do_enddo=1
" Setup minibugexplorer to use ctrl + arrows and tabs
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapCTabSwitchBufs = 1
" Binds shift-f and ctrl-f to detecting fortran syntax highlighting for
" fixed/free
" nmap <S-F> :set syntax=fortran<CR>:let b:fortran_fixed_source=!b:fortran_fixed_source<CR>:set syntax=text<CR>:set syntax=fortran<CR>
" nmap <C-F> :filetype detect<CR>

" Binds ctrl-bs to delete a word in insert
"imap <BS> <C-W>
" Binds ctrl-del delete a word in insert
imap <C-kDel> <C-O>caw

" starts nerd tree and sets cursor to main window
"autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
" Shortcut to toggle NERDTree<F4><F4><F4>
nmap <F3> :NERDTreeToggle<CR>
" Easier split navigation
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
" prevent MBE from opening in unmodifiable buffers, I think
let g:miniBufExplModSelTargelt = 1
" Stuff for snipMate
:filetype plugin on

" map Option+Left/Option+Right:
" for this to work you must have the bindings in Settings > Keyboard set
" as follows:
" 'option cursor left' to '\033b'
" 'option cursor right' to '\033f'
:map <ESC>f e
:imap <ESC>b <C-o>b
:imap <ESC>f <C-o>e
:cmap <ESlC>f e
" Spacing to 2 for YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab

