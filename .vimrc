"Author: Andrew Chen

"Vim-Plug {{{
call plug#begin('~/.vim/plugged')
" colorschemes
Plug 'arzg/vim-colors-xcode'
Plug 'romainl/Apprentice'
Plug 'morhetz/gruvbox'

" statusline configuration
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes' 

" file navigation
Plug 'ctrlpvim/ctrlp.vim'

" nerd tree
" https://github.com/preservim/nerdtree
Plug 'preservim/nerdtree'

" wiki 
" https://github.com/vimwiki/vimwiki
Plug 'vimwiki/vimwiki'

" git
" show changed lines https://github.com/airblade/vim-gitgutter
"Plug 'airblade/vim-gitgutter'

" code format
" see https://github.com/google/vim-codefmt
" Add maktaba and codefmt to the runtimepath.
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
call plug#end()

"{{{Variable definition & configuration
" airline https://github.com/vim-airline/vim-airline
" airline theme: https://github.com/vim-airline/vim-airline-themes
let g:airline_theme='simple'

" set <Leader>
let mapleader=","

" completing vim-codefmt installation
call glaive#Install()
" enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
"}}}
"}}}

" Vim options set {{{
set wrap                         " defualt on, wrap text if exceed the terminal window width
set expandtab                    " get rid of tabs altogether and replace with spaces
set autoindent                   " new line indent match the current one 
set number
set relativenumber               " set relative number in addition to line number (display current line number)
set cindent                      " c code indenting
set foldcolumn=1                 " display fold column for folds 
set foldmethod=marker
set foldlevelstart=99            " open all fold initially
set ignorecase                   " do case insensitive matching
set smartcase                    " if search pattern is lowercase -> ignorecase, otherwise not
set linebreak                    " when wrapping long lines, don't break up words. 
set nocompatible                 " use vim defaults 
set ruler                        " ruler at the bottom 
set tabstop=4                    " show existing tab with 4 spaces width
set shiftwidth=4                 " on pressing tab, insert 4 spaces
set softtabstop=4                " 
set scrolloff=1                  " keep cursor 1 row away from edge to scroll

set showcmd                      " show (partial) command in status line
set showmatch                    " show matching brackets
set textwidth=0                  " don't wrap words by default
" disable wrapping line 
"set textwidth=90                 " wraps a line with a break when reached 90 chars
set wildmenu                     " used with wildmode(full) to cycle options
set cursorline
set incsearch                    " highlight possible search when type /pattern

" longer options
set whichwrap+=<,>,[,],h,l,~               " arrow keys can wrap in normal and insert modes

" Don't understand the following settings
"set cscopequickfix=s-,c-,d-,i-,t-,e-,g-,f- " useful for cscope in quickfix
"set tags+=./.tags;/,./tags;/               " set ctags
" Suffixes that get lower priority when doing tab completion for filenames.
" These are files I am not likely to want to edit or read
"set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.class

"Turn on filetype plugins automatically {{{
"plugin and indent setting for particular filetypes. 
filetype plugin on
filetype indent on
"}}}

"{{{Cursor
let &t_EI = "\<Esc>[2 q"    " block cursor for normal mode
let &t_SR = "\<Esc>[3 q"    " underline cursor for replace mode
let &t_SI = "\<Esc>[5 q"    " I beam cursor for insert mode, SI = start insert
"}}}
"
"{{{ Colorscheme
syntax enable
set termguicolors " enable true colors support
colorscheme gruvbox
"}}}
" }}}

" Key mapping {{{
" disable arrow keys in normal
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <down> <nop>
nnoremap <up> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>
vnoremap <down> <nop>
vnoremap <up> <nop>
" in insert mode <c-o> lets you escape insert and do one normal mode command  
" gk/j when text wrap on, go N lines up/down (rather than the whole wrapped line)
inoremap <c-k> <c-o>gk
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <c-j> <c-o>gj
inoremap <c-e> <c-o>$
inoremap <c-a> <c-o>0

"c-j - insert new line in normal mode without going into insert
nnoremap <c-j> o<Esc>
" delete inline
nnoremap dil 0D
" yank inline
nnoremap yil 0y$
" not vi compatible
nnoremap Y y$
" switching between tabs: https://vim.fandom.com/wiki/Using_tab_pages
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
" }}}

"{{{ Command & Functions
" https://devhints.io/vimscript

"{{{ Notable
command Notable call s:notableHeader()

" ! after function https://vi.stackexchange.com/questions/18782/exclamation-mark-after-autocommands
function s:notableHeader()
    " return the note header for notable
    " %F = %Y-%m-%d
    let creationTime = s:zuluTime()
    " https://vim.fandom.com/wiki/Get_the_name_of_the_current_file
    let fileName = expand('%:t:r')
    " '.' is the concatenation operator https://learnvimscriptthehardway.stevelosh.com/chapters/26.html
    let headers = ["---", "tags: []", "title: ".fileName, "created: '".creationTime."'", "modified: '".creationTime."'", "---"]
    let @"=join(headers,"\n")
    normal! p
endfunction

function s:zuluTime()
    " return UTC time, change if microsecond needed
    " date micro second not implemented on OSX
    " system(cmd) returns the result of command (string) but appends a newline 
    " systemlist(cmd) return the result in list
    " [:] string slicing 
    return system('date -u "+%Y-%m-%dT%H:%M:%S.000Z"')[:-2] " upperbound is inclusive 
endfunction
" }}}
"}}}

"Common Autocmd & Augroup {{{
"
augroup incsearch-highlight
    " together with incsearch on, highlight all pattern matched when typed "/pattern"
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup end

"}}}

" Vim {{{
" why use augroup: https://vi.stackexchange.com/questions/9455/why-should-i-use-augroup
augroup ft_vim
    " au! = autocmd!
    au! 
    " use marker method of folding for any vim files
    au filetype vim setlocal foldmethod=marker foldmarker={{{,}}}
    " fold all folders
    au filetype vim normal zM
    "au filetype vim nnoremap <leader>b :RegionBlock<CR>
augroup end

"}}}

" Markdown {{{
" From youtube: https://www.youtube.com/watch?v=9Bb8Ljyqpt4
" [rR]md is the R Markdown file format, I don't use it so will omit
    autocmd Filetype markdown inoremap <leader>s ~~~~<++><Esc>F~hi
    autocmd Filetype markdown map <leader>w yiWi[<Esc>Ea](<Esc>pa)
    autocmd Filetype markdown inoremap <leader>n ---<CR><CR>
    autocmd Filetype markdown inoremap <leader>b **<++><Esc>F*i
    autocmd Filetype markdown inoremap <leader>i __<++><Esc>F_i
    autocmd Filetype markdown inoremap <leader>fn ^[]<Esc>F[a
    autocmd Filetype markdown inoremap <leader>l [](<++>)<++><Esc>F[a
    autocmd Filetype markdown inoremap <leader>1 #<Space><CR><CR><++><Esc>2kA
    autocmd Filetype markdown inoremap <leader>2 ##<Space><CR><CR><++><Esc>2kA
    autocmd Filetype markdown inoremap <leader>3 ###<Space><CR><CR><++><Esc>2kA
    autocmd Filetype markdown inoremap <leader>4 ####<Space><CR><CR><++><Esc>2kA
    autocmd Filetype markdown inoremap <leader>5 #####<Space><CR><CR><++><Esc>2kA
    autocmd Filetype markdown inoremap <leader>6 ######<Space><CR><CR><++><Esc>2kA
    
    "=============================="
    "    Vimwiki Markdown Cmd's    "
    "=============================="

" }}}

" Archive {{{
" 
" This adds a comment frame, but there's a plugin already for it that does better job
"command CommentFrame call s:block(30)
"
"function s:block(n)
"    " to use arg in command (not used here): 
"    " https://vi.stackexchange.com/questions/9644/how-to-use-a-variable-in-the-expression-of-a-normal-command
"    if (a:n < 4) 
"        return
"    endif
"    let third = a:n/3
"
"    exe \":normal o\<esc>..kkk"
"    exe \":normal a\"".repeat("=", a:n)."\"\n"
"    exe \":normal a\"".repeat(" \", third)."\"\n"
"    exe \":normal a\"".repeat("=", a:n)."\""
"    exe \":normal kF\"".third."l"
"    " why doesn't :normal i enter insert mode 
"    " https://stackoverflow.com/questions/11587124/vim-why-doesnt-normal-i-enter-insert-mode
"    :startinsert
"endfunction
"
"
" No idea what the followings are for
" sit back and let autoformat happen automatically
" yapf breaks
"augroup autoformat_settings
"  autocmd FileType bzl AutoFormatBuffer buildifier
"  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
"  autocmd FileType dart AutoFormatBuffer dartfmt
"  autocmd FileType go AutoFormatBuffer gofmt
"  autocmd FileType gn AutoFormatBuffer gn
"  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
"  autocmd FileType java AutoFormatBuffer google-java-format 
"  " Alternative: autocmd FileType python AutoFormatBuffer yapf
"  autocmd FileType python AutoFormatBuffer autopep8
"  autocmd FileType rust AutoFormatBuffer rustfmt
"  autocmd FileType vue AutoFormatBuffer prettier
"augroup END
" }}}
