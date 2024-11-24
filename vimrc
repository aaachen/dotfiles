"Author: Andrew Chen
"https://github.com/aaachen

"Vim-Plug {{{
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
" Install vimplug if don't exist
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" all those plugs are appended to runtimepath - echo &runtimepath
call plug#begin('~/.vim/plugged')
" status line (70 -> ~90 ms start time): 
" https://github.com/itchyny/lightline.vim
Plug 'itchyny/lightline.vim'

" colorschemes
Plug 'arzg/vim-colors-xcode'
Plug 'morhetz/gruvbox'

" 01/16/2023: Retiring vimwiki
" vimwiki
" https://github.com/vimwiki/vimwiki
" Plug 'vimwiki/vimwiki'

" distraction free writing
" https://github.com/junegunn/goyo.vim https://github.com/junegunn/limelight.vim
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" fzf vim integration, use CtrlP on windows machine
" https://github.com/junegunn/fzf
Plug 'junegunn/fzf',  { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" nerd tree
" https://github.com/preservim/nerdtree
Plug 'preservim/nerdtree'
" extension to add visual-select
" https://github.com/PhilRunninger/nerdtree-visual-selection
Plug 'PhilRunninger/nerdtree-visual-selection'

" unix helper
" https://github.com/tpope/vim-eunuch
Plug 'tpope/vim-eunuch'

" ultisnip
" https://github.com/SirVer/ultisnips
" Plug 'SirVer/ultisnips'
" common snippets
" https://github.com/honza/vim-snippets
" Plug 'honza/vim-snippets'

" Debug startup performance
" https://github.com/dstein64/vim-startuptime
Plug 'dstein64/vim-startuptime'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

call plug#end()

"}}}

" Options {{{
set laststatus=2

set wrap                         " defualt on, wrap text if exceed the terminal window width
set expandtab                    " get rid of tabs altogether and replace with spaces
set autoindent                   " new line indent match the current one 
set number
set relativenumber               " set relative number in addition to line number (display current line number)

"set cindent                      " c code indenting. Disabling as it removes intial indent when typing # comment 
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

" set <Leader>
let mapleader=","

" Turn on filetype plugins automatically 
" https://vi.stackexchange.com/questions/10124/what-is-the-difference-between-filetype-plugin-indent-on-and-filetype-indent
filetype plugin on
filetype indent on

" https://github.com/ryanoasis/vim-devicons
set encoding=UTF-8

" Cursor
let &t_EI = "\<Esc>[2 q"    " block cursor for normal mode
let &t_SR = "\<Esc>[3 q"    " underline cursor for replace mode
let &t_SI = "\<Esc>[5 q"    " I beam cursor for insert mode, SI = start insert

" Color Scheme
syntax on
" for typescript file performance: https://jameschambers.co.uk/vim-typescript-slow
set re=0
colorscheme gruvbox
set termguicolors " enable true colors support

" make alt key work 
" source: https://github.com/dylnmc/placeholder.vim
if !has('nvim') && !has('gui_running')
    " allow M-{key} to be mapped properly in term vim
    exe "set <m-r>=\<esc>r"
    if exists(':tnoremap')
        " fix above maps in terminal mode
        tnoremap <m-r> <esc>r
    endif
endif
" }}}

" Key mapping {{{
" paste latest yanked register content. Default p will replace anon register
noremap <leader>p "0p
nnoremap <leader>; ,
" format paragraph
" https://superuser.com/questions/275364/how-can-i-break-a-paragraph-into-sentences-with-vim
vnoremap \f :s/\. /.<c-v><CR>/g<CR>

" disable arrow keys in normal
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <down> <nop>
nnoremap <up> <nop>
"c-j - insert new line in normal mode without going into insert
" nnoremap <c-j> o<Esc>
" https://stackoverflow.com/questions/11993851/how-to-delete-not-cut-in-vim
" nnoremap <c-k> "_ddk


" delete inline
nnoremap dil 0D
" yank inline
nnoremap yil 0y$
" not vi compatible
nnoremap Y y$
" switching between tabs: https://vim.fandom.com/wiki/Using_tab_pages
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <leader>t :call CreateNewTabWithSameFile()<CR>

function! CreateNewTabWithSameFile()
    if empty(@%)
        tabnew
    else
        tabnew %
    endif
endfunction

" replaced ctrl-P with fzf
nnoremap <C-P> :Files<CR>
" search for pattern from current working directory
nnoremap <leader><C-P> :Rg 

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

nnoremap \ :call ToggleNerdFind()<CR>

" https://learnvim.irian.to/vimscript/vimscript_variable_scopes
" Buffer variable scope so multiple window's ToggleNerdFind doesn't run into each other
au BufEnter * if !exists('b:acheamzNerdFindToggle') | let b:acheamzNerdFindToggle = 0 | endif

function! ToggleNerdFind()
    if b:acheamzNerdFindToggle
        NERDTreeClose
        let b:acheamzNerdFindToggle = 0
    else
        NERDTreeFind
        let b:acheamzNerdFindToggle = 1
    endif
endfunction

" https://vim.fandom.com/wiki/Detect_window_creation_with_WinEnter
autocmd WinEnter * nnoremap <C-h> <C-w>h
autocmd WinEnter * nnoremap <C-l> <C-w>l
autocmd WinEnter * nnoremap <C-k> <C-w>k
autocmd WinEnter * nnoremap <C-j> <C-w>j

" alt left/right
nnoremap <Esc>[1;3D :tabmove -1<CR>
nnoremap <Esc>[1;3C :tabmove +1<CR>

nnoremap <m-r> /<++>/<CR>vf>di
inoremap <m-r> <Esc>/<++>/<CR>vf>di

" apply macros to set of lines: https://stackoverflow.com/questions/390174/in-vim-how-do-i-apply-a-macro-to-a-set-of-lines
vnoremap <leader>m :norm! @

" https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
" use CR instead of <c-y> to select an item in completion
" This may be unneeded when switch to use YouCompleteMe later on

" This is overwritten by vimwikireturn. It is also passed as EunuchNewLine
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:set_writing_settings() abort
    nnoremap j gj
    nnoremap k gk
endfunction

au BufEnter /home/andrew/workspace/forest/* call s:set_writing_settings()
" }}}

"{{{ Autocmd (Common)
" https://devhints.io/vimscript
augroup incsearch-highlight
    " together with incsearch on, highlight all pattern matched when typed "/pattern"
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup end
"}}}

" File Types {{{ 

" Markdown {{{
augroup md
    au!
    let maplocalleader="\<Space>"
    " delete link, maybe move this to visual mode
    autocmd Filetype markdown nnoremap <localleader>dl F[xf]xvf)d
    " https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)#Visual_mode_maps
    " modify around selected block of text
    autocmd Filetype markdown vnoremap <leader>b <Esc>`>a**<Esc>`<i**<Esc>
    autocmd Filetype markdown vnoremap <leader>i <Esc>`>a*<Esc>`<i*<Esc>
    " Add link, the vimwiki enter is great for generating new wiki but not for inserting link
    autocmd Filetype markdown vnoremap <leader>l <Esc>`<i[<Esc>`>a](<++>)<Esc>
    autocmd Filetype markdown vnoremap <leader>c <Esc>`<i`<Esc>`>a`<Esc>
    autocmd Filetype markdown vnoremap <leader>,c c```<CR>```<Esc>kp
    " underline is not supported in markdown
augroup end
" }}}

" Vim {{{
augroup ft_vim
    " au! = autocmd!
    au! 
    " use marker method of folding for any vim files
    au filetype vim setlocal foldmethod=marker foldmarker={{{,}}}
    " fold all folders
    au filetype vim normal zM
    " https://superuser.com/questions/271023/can-i-disable-continuation-of-comments-to-the-next-line-in-vim
    au filetype vim setlocal formatoptions-=cro
augroup end
"}}}

" }}}

" Vimwiki {{{

" required for ultisnip to work: https://github.com/vimwiki/vimwiki/issues/357
let g:vimwiki_table_mappings = 0
" required to not set filetype for all md: https://github.com/vimwiki/vimwiki/issues/95
let g:vimwiki_global_ext = 0

" convention: path ending in '/' indicates a directory
" let $VIMWIKI_ROOT = '/home/andrew/vimwiki/'
" let $VIMWIKI_DIARY_ROOT = $VIMWIKI_ROOT .. "diary/"

" Append to this list so each path becomes its own wiki. 
let g:vimwiki_list = [{'path': $VIMWIKI_ROOT, 'syntax': 'markdown', 'ext': '.md'}] 
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown', '.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
" Makes vimwiki markdown links as [text](text.md) instead of [text](text)
let g:vimwiki_markdown_link_ext = 1

let g:taskwiki_markup_syntax = 'markdown'
let g:markdown_folding = 1

" TODO: insert front matter header (create new function that call sets title and tag, assuming cwd is correct)
command SaveQuestion call s:set_file_name_to_title_md($VIMWIKI_ROOT.."dev/questions/") | w
command SaveInbox call s:set_file_name_to_title_md($VIMWIKI_ROOT.."inbox/") | w

" arg:directory path
function! s:set_file_name_to_title_md(root) abort
    " clear register t
    call setreg("t", [])
    :execute "normal gg/^# \<cr>\"ty$"
    let title = @t
    " Strip special characters, leading, trailing white space, join in between white space with _
    let title = system("sed -r -e 's/[#\*\?\@\!\$\%\^\&\*\(\)\~]//g' -e 's/^[ \t]*//g' -e 's/[ \t]*$//g' -e 's/[ \t]+/_/g'<<<\""..title.."\"")[:-2]
    " do fnameescape to escape special characters just to be safe
    silent execute "file "..a:root..fnameescape(title)..".md"
endfunction

" }}}

" Goyo {{{

" https://www.youtube.com/watch?v=2cIdnfT5zxA
let g:goyo_width = '80%'
let g:goyo_height = '90%'
" larger -> more contrast
let g:limelight_default_coefficient = 0.7
" highlight more than current paragraph (i.e. surrounding paragraph)
" let g:limelight_paragraph_span = 1

map <leader>\ :Goyo<CR>
"map <leader>lime :Limelight!!<CR>
" When enter goyo turn on limelight, custom event handler prob handled by
" Goyo library 
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

"}}}

" Ultisnip {{{
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
"let g:UltiSnipsExpandTrigger="<tab>"

" let :UltiSnipsEdit split window.
let g:UltiSnipsEditSplit="vertical"

"}}}

