" -*- vim -*-
" FILE: "/home/dp/.vim/colors/potts2.vim" {{{
" LAST MODIFICATION: "Fri, 08 Feb 2002 09:47:10 (dp)"
" (C) 2001 by Douglas L. Potts, <dlpotts@spectral-sys.com>
" $Id: potts2.vim,v 1.3 2002/02/18 20:25:27 dp Exp $ }}}

set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="potts"

highlight SpecialKey ctermfg=9 
highlight NonText ctermfg=9 
highlight Directory ctermfg=117 
highlight ErrorMsg ctermfg=15 ctermbg=4 
highlight IncSearch cterm=reverse 
highlight Search ctermfg=15 ctermbg=69 
highlight MoreMsg ctermfg=69 
highlight ModeMsg cterm=bold 
highlight LineNr ctermfg=244 
highlight Question ctermfg=69 
highlight StatusLine cterm=bold,reverse 
highlight StatusLineNC cterm=reverse 
highlight VertSplit cterm=reverse 
highlight Title ctermfg=69 
highlight Visual cterm=reverse 
highlight VisualNOS cterm=bold,underline 
highlight WarningMsg ctermfg=69 
highlight WildMenu ctermfg=0 ctermbg=69 
highlight Folded cterm=bold ctermfg=117 
highlight FoldColumn cterm=bold ctermfg=117 
highlight DiffAdd ctermfg=69 ctermbg=9 
highlight DiffChange ctermfg=15 ctermbg=9 
highlight DiffDelete ctermfg=69 ctermbg=117 
highlight DiffText cterm=bold ctermfg=15 ctermbg=69 
highlight Normal ctermbg=235 ctermfg=15
highlight Comment ctermfg=244 
highlight Constant ctermfg=117
highlight Function ctermfg=222
highlight Special ctermfg=222
highlight Identifier cterm=NONE ctermfg=203
highlight Statement cterm=bold ctermfg=69 
highlight PreProc ctermfg=9 
highlight Type cterm=bold ctermfg=69 
highlight Underlined cterm=underline ctermfg=9 
highlight Ignore ctermfg=0 
highlight Error ctermfg=15 ctermbg=69 
highlight Todo ctermfg=0 ctermbg=69 
highlight DebugBreak ctermfg=15 ctermbg=4 
highlight DebugStop ctermfg=15 ctermbg=69 
