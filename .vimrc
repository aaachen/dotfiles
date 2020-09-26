"Vim-Plug{{{
call plug#begin('~/.vim/plugged')
" colorschemes
Plug 'jcherven/jummidark.vim'
Plug 'arzg/vim-colors-xcode'
Plug 'pgavlin/pulumi.vim'
Plug 'sainnhe/sonokai'
call plug#end()
"}}}

" Standard vim options {{{
set expandtab                    " get rid of tabs altogether and replace with spaces
set autoindent                   " new line indent match the current one 
set number
set cindent                      " c code indenting
set foldcolumn=1
set foldmethod=marker
set foldlevelstart=99            " open all fold initially
set ignorecase                   " do case insensitive matching
set linebreak                    " this displays long lines as wrapped at word boundries 
set nocompatible                 " use vim defaults 
set ruler                        " ruler at the bottom 
set tabstop=4                    " show existing tab with 4 spaces width
set shiftwidth=4                 " on pressing tab, insert 4 spaces
set softtabstop=4                " 
set scrolloff=1                  " keep cursor 1 row away from edge to scroll
set showcmd                      " show (partial) command in status line
set showmatch                    " show matching brackets
set textwidth=0                  " don't wrap words by default
set textwidth=90                 " wraps a line with a break when reached 90 chars
set wildmenu                     " used with wildmode(full) to cycle options
" }}}

" Key mapping {{{
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <down> <nop>
nnoremap <up> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>
vnoremap <down> <nop>
vnoremap <up> <nop>
" gk/j when wrap on, go N lines up/down 
inoremap <c-k> <c-o>gk
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <c-j> <c-o>gj
inoremap <c-e> <c-o>$
inoremap <c-a> <c-o>0
" }}}

"Turn on filetype plugins automatically {{{
  "Grab commands for particular filetypes. Grabbed from $VIM/ftplugin <- what's this 
  filetype plugin on
  filetype indent on
"}}}

"Autocmd & Augroup {{{
augroup ft_vim
    au!
    au filetype vim setlocal foldmethod=marker foldmarker={{{,}}}
    au filetype vim normal zM
augroup end
augroup ft_js
    au!
    au filetype javascript setlocal foldmethod=marker foldmarker={,}
augroup end
"}}}

"{{{Cursor
let &t_EI = "\<Esc>[2 q"    " block cursor for normal mode
let &t_SR = "\<Esc>[3 q"    " underline cursor for replace mode
let &t_SI = "\<Esc>[5 q"    " I beam cursor for insert mode, SI = start insert
"}}}

syntax enable
colorscheme xcodedark
