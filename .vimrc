"Author: Andrew Chen
"https://github.com/aaachen

"Vim-Plug {{{
call plug#begin('~/.vim/plugged')
" colorschemes
Plug 'arzg/vim-colors-xcode'
Plug 'morhetz/gruvbox'

" statusline configuration
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes' 

" https://github.com/vimwiki/vimwiki
Plug 'vimwiki/vimwiki'

" distraction free writing
" https://github.com/junegunn/goyo.vim https://github.com/junegunn/limelight.vim
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" fzf vim integration, use CtrlP on windows machine
" https://github.com/junegunn/fzf
Plug 'junegunn/fzf',  { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Debug
" https://github.com/dstein64/vim-startuptime
Plug 'dstein64/vim-startuptime'

" Unused plugins {{{
" Code format
" see https://github.com/google/vim-codefmt
" Add maktaba and codefmt to the runtimepath.
" Plug 'google/vim-maktaba'
" Plug 'google/vim-codefmt'
" Plug 'google/vim-glaive'

" This is post hook, use the VimEnter hook http://vimdoc.sourceforge.net/htmldoc/autocmd.html#VimEnter
" VimEnter * ..., This way does not delay loading buffer
" completing vim-codefmt installation
" call glaive#Install()
" enable codefmt's default mappings on the <Leader>= prefix.
" Glaive codefmt plugin[mappings]

" Align https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'

" https://github.com/francoiscabrol/ranger.vim
" Plug 'francoiscabrol/ranger.vim'

" Ranger https://github.com/francoiscabrol/ranger.vim
"let g:ranger_map_keys = 0
"nnoremap <leader>r :Ranger<CR>

" https://github.com/airblade/vim-rooter
" Plug 'airblade/vim-rooter'
" Git-vim integration 
" https://github.com/tpope/vim-fugitive 
" Plug 'tpope/vim-fugitive'

" Git commit browser
" https://github.com/junegunn/gv.vim
" Plug 'junegunn/gv.vim'

" show changed lines https://github.com/airblade/vim-gitgutter
" Plug 'airblade/vim-gitgutter'

" nerd tree
" https://github.com/preservim/nerdtree
" Plug 'preservim/nerdtree'

" unix helper
" https://github.com/tpope/vim-eunuch
" Plug 'tpope/vim-eunuch'

" *** snippet
" https://github.com/SirVer/ultisnips
" Plug 'SirVer/ultisnips'
" }}} 

call plug#end()

"}}}

" Options {{{
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

" set <Leader>
let mapleader=","
" Don't understand the following settings
"set cscopequickfix=s-,c-,d-,i-,t-,e-,g-,f- " useful for cscope in quickfix
"set tags+=./.tags;/,./tags;/               " set ctags
" Suffixes that get lower priority when doing tab completion for filenames.
" These are files I am not likely to want to edit or read
"set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.class

"plugin and indent setting for particular filetypes {{{
" Turn on filetype plugins automatically 
filetype plugin on
filetype indent on
"}}}

" https://stackoverflow.com/questions/40141569/how-to-treat-a-makefile-with-another-name-in-vim
autocmd Bufenter ~/.aliases set syntax=zsh

" Cursor
let &t_EI = "\<Esc>[2 q"    " block cursor for normal mode
let &t_SR = "\<Esc>[3 q"    " underline cursor for replace mode
let &t_SI = "\<Esc>[5 q"    " I beam cursor for insert mode, SI = start insert

" Color Scheme
syntax enable
colorscheme gruvbox
set termguicolors " enable true colors support
" }}}

" Key mapping {{{
" Resource: https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_2)
" - finding unused keys: map map!, verbose map <key>
" - take advantage of function keys as those aren't used generally

" paste latest yanked register content. Default p will replace anon register
noremap <leader>p "0p
" disable arrow keys in normal
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <down> <nop>
nnoremap <up> <nop>
"c-j - insert new line in normal mode without going into insert
nnoremap <c-j> o<Esc>
" https://stackoverflow.com/questions/11993851/how-to-delete-not-cut-in-vim
nnoremap <c-k> "_ddk
" delete inline
nnoremap dil 0D
" yank inline
nnoremap yil 0y$
" not vi compatible
nnoremap Y y$
" switching between tabs: https://vim.fandom.com/wiki/Using_tab_pages
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <leader>t :tabnew<CR>
" replace ctrl-P with fzf
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

" https://vim.fandom.com/wiki/Detect_window_creation_with_WinEnter
autocmd WinEnter * nnoremap <C-h> <C-w>h
autocmd WinEnter * nnoremap <C-l> <C-w>l
" The c-j conflicts with above, and I don't wanna map that to <CR>
" since most times I'd just be editing two files vertically at same time not mapping the c-j
" autocmd WinEnter * nnoremap <C-j> <C-w>j
" autocmd WinEnter * nnoremap <C-k> <C-w>k

" mapping alt key: https://vi.stackexchange.com/questions/2350/how-to-map-alt-key
" A key with the Alt key modifier is represented using <A-key> or <M-key> notation 
" Directly using that doesn't work, that's because both alt and esc emit ^[ 
" One way to do is remap the alt to some other escape sequence (in link) but didnt work for me
" Second way is just directly let vim interpret the ^[ as <Esc>. Note tho that this does not mean <Esc>+key == <Alt>+key
" can check that on cat, compare alt+left with esc+left
" Below maps Alt-left and Alt-right respectively for reorganizing tabs (idk how to add shift also in combination
nnoremap <Esc>[1;3D :tabmove -1<CR>
nnoremap <Esc>[1;3C :tabmove +1<CR>

" https://vi.stackexchange.com/questions/7194/how-to-substitute-the-first-occurrence-across-the-whole-file " The below method somehow skips the current line during search
"autocmd Filetype markdown nnoremap <leader>, :/ *<++>/s///<CR>A
"autocmd Filetype markdown inoremap <leader>, <Esc>:/ *<++>/s///<CR>A
 
" if there's no character after <++> or is the <CR>, then cursor will be at character before < and i will start at position before that character 
    " it's this behavior cuz cursor can't be on <CR>
" if there's character after, then cursor will be at < and start before it (behavior we want).
    " this is the case of link and anytime we want to insert snippet in middle of sentence
" just live with former case. make replacing place holder string not limited to only markdown
nnoremap <leader>, /<++>/<CR>vf>di
inoremap <leader>, <Esc>/<++>/<CR>vf>di
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
" From youtube: https://www.youtube.com/watch?v=9Bb8Ljyqpt4
" [rR]md is the R Markdown file format, I don't use it so will omit
augroup md
    au!
    " autocmd Filetype markdown nnoremap <leader>td 0i- [ ] <Esc> 
    autocmd Filetype markdown inoremap <leader>td <c-o>0- [ ] <c-o>$
    autocmd Filetype markdown inoremap <leader>s ~~~~ <++><Esc>F~hi
    " autocmd Filetype markdown map <leader>w yiWi[<Esc>Ea](<Esc>pa)
    autocmd Filetype markdown inoremap <leader>n ---<CR><CR>
    autocmd Filetype markdown inoremap <leader>i ** <++><Esc>F*i
    autocmd Filetype markdown inoremap <leader>b **** <++><Esc>F*hi
    " https://www.markdownguide.org/extended-syntax/#footnotes
    autocmd Filetype markdown inoremap <leader>fn [^]<Esc>F[la
    autocmd Filetype markdown inoremap <leader>l [](<++>) <++><Esc>F[a
    autocmd Filetype markdown inoremap <leader>1 #<Space><CR><CR><++><Esc>2kA
    autocmd Filetype markdown inoremap <leader>2 ##<Space><CR><CR><++><Esc>2kA
    autocmd Filetype markdown inoremap <leader>3 ###<Space><CR><CR><++><Esc>2kA
    autocmd Filetype markdown inoremap <leader>4 ####<Space><CR><CR><++><Esc>2kA
    autocmd Filetype markdown inoremap <leader>5 #####<Space><CR><CR><++><Esc>2kA
    autocmd Filetype markdown inoremap <leader>6 ######<Space><CR><CR><++><Esc>2kA
    
"------------------------------------------------------------------------------"
"                             Vimwiki Markdown Cmd                             "
"------------------------------------------------------------------------------"

    " TODO: migrate those to ulti-snip later
    " Want question to be able to created from any vim buffer
    nnoremap <leader>qs i#<Space><++><Space><CR><CR>**Link:** <++> <CR><CR>##<Space>Description: <CR><CR><++> <CR><CR>##<Space>Answer: <CR><CR><++><Esc>gg
    " Not really needed with the template script
    autocmd FileType markdown nnoremap <leader>diary i#<Space><++><Space><CR><CR><++><CR><CR>##<Space>DevLog<CR><CR><++><CR><CR><Esc>gg
    autocmd FileType markdown nnoremap <leader>note i#<Space><++><Space><CR><CR>##<Space>Explain<CR><CR><++><CR><CR>##<Space>Documentation<CR><CR><CR><CR>##<Space>Code<CR><CR>```<CR>```<Esc>gg
    autocmd Filetype markdown inoremap <leader>now *<CR><Esc>!!date<CR>A*<Esc>kJxA<CR><CR>
augroup end
" }}}

" Vim {{{
" why use augroup: https://vi.stackexchange.com/questions/9455/why-should-i-use-augroup
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

"{{{ Notable
command Notable call s:notable_header()

" ! after function https://vi.stackexchange.com/questions/18782/exclamation-mark-after-autocommands
function s:notable_header()
    " return the note header for notable
    " %F = %Y-%m-%d
    let creationTime = s:zulu_time()
    " https://vim.fandom.com/wiki/Get_the_name_of_the_current_file
    let fileName = expand('%:t:r')
    " '.' is the concatenation operator https://learnvimscriptthehardway.stevelosh.com/chapters/26.html
    let headers = ["---", "tags: []", "title: ".fileName, "created: '".creationTime."'", "modified: '".creationTime."'", "---"]
    " https://learnvimscriptthehardway.stevelosh.com/chapters/19.html#registers-as-variables
    let @"=join(headers,"\n")
    normal! p
endfunction

function s:zulu_time()
    " return UTC time, change if microsecond needed
    " date micro second not implemented on OSX
    " system(cmd) returns the result of command (string) but appends a newline 
    " systemlist(cmd) return the result in list
    " [:] string slicing 
    return system('date -u "+%Y-%m-%dT%H:%M:%S.000Z"')[:-2] " upperbound is inclusive 
endfunction
" }}}

" Vimwiki {{{
    " append to this list so each path becomes its own wiki
    let g:vimwiki_list = [
                \{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
                "\{'path': '~/vimwiki/linux', 'syntax': 'markdown', 'ext': '.md'}]
    let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown', '.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
    " Makes vimwiki markdown links as [text](text.md) instead of [text](text)
    let g:vimwiki_markdown_link_ext = 1

    let g:taskwiki_markup_syntax = 'markdown'
    let g:markdown_folding = 1

    " Custom Commands & Functions{{{
    """ this function generates a list of links in curr directory and first sub directory index
    command VimwikiGenerateCurrDirLinks call s:vimwiki_curr_dir_links()
    
    function s:vimwiki_curr_dir_links()
        " get current dir non-index wikis
        " https://unix.stackexchange.com/questions/55359/how-to-run-grep-with-multiple-and-patterns
        let l1_files = system('find . -mindepth 1 -maxdepth 1 -not -path "*/.*" -type f | awk "!/index\.md/ && /\.md/" | cut -c 3-')
        " only get immediate subdirectories index wiki
        let l2_files = system('find . -mindepth 2 -maxdepth 2 -not -path "*/.*" -type f | grep "index.md" | cut -c 3-')
        for file in split(l1_files, "\n")
            " remove .md
            let l = "[".file[:-4]."](".file.")"
            put! =l
        endfor
        
        for file in split(l2_files, "\n")
            " use directory name as name of link
            let dir_name = split(file, "/")[0]
            let l = "[".dir_name."](".file.")"
            put! =l
        endfor
    endfunction
    
    """ arg:path directory path. Should not end in '/'
    " abort function if error, so subsequent commands are not executed
    " https://vi.stackexchange.com/questions/29038/how-do-i-make-a-function-stop-when-an-error-occurs
    function! SetFileNameToTitleMd(path) abort
        " !!! Remember to escape special character in exec string !!!
        " using ' doesn't allow for interpolation https://stackoverflow.com/questions/13435586/should-i-use-single-or-double-quotes-in-my-vimrc-file 
        " so those don't work cuz the \ is interpreted literally
        " execute('normal gg/#\<cr>y$') :execute 'normal gg/#\<cr>y$'
        " clear register t
        call setreg("t", [])
        :execute "normal gg/#\<cr>\"ty$"
        let title = @t
        let title = system("sed -e 's/[#\*\?\@\!\$\%\^\&\*\(\)\~]//g' -e 's/^ *//g' -e 's/ /_/g' <<<\"".title."\"")[:-2]
        " do fnameescape to escape special characters just to be safe
        silent execute "file ".a:path."/".fnameescape(title).".md"
    endfunction
    " }}}

" If I want to use variable in mapping I have to do :exe 'map '.l:variable'something'
" let l:vimwiki_path = '~/vimwiki'

" tip to debug mapping:
" search mapping -> :verbose map
augroup vim_wiki
    au! 
    " https://stackoverflow.com/questions/2437777/with-vim-how-can-i-use-autocmds-for-files-in-subdirectories-of-a-specific-path
    autocmd BufRead,BufNewFile ~/vimwiki/* nnoremap <C-P> :Files ~/vimwiki/<CR>
    " https://github.com/junegunn/fzf.vim/issues/837
    " :h user-functions -> !, replaces a function if one already exists
    command! -bang -nargs=* VimwikiRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': "~/vimwiki"}), <bang>0)
    autocmd BufRead,BufNewFile ~/vimwiki/* nnoremap <leader><C-P> :VimwikiRg 
    " remove a link
    autocmd BufRead,BufNewFile ~/vimwiki/* nnoremap <leader><CR> F[xf]xvf)d
    autocmd BufRead,BufNewFile ~/vimwiki/* nmap <C-x> <Plug>VimwikiToggleListItem
    " let vim change the cwd for VimwikiGenerateCurrDirLinks to work
    if exists('+autochdir')
        autocmd BufRead,BufNewFile ~/vimwiki/* set autochdir
    endif
    """ Questions 

    " sq == save question
    " Note: for the below, the '|' needs to be escaped otherewise it causes problem for some reason
    " nnoremap <leader>sq :execute 'call SetFileNameToTitleMd("~/vimwiki/dev/questions") \| w'<CR>
    nnoremap <leader>sq :call SetFileNameToTitleMd("~/vimwiki/dev/questions") \| w<CR>

    " do ":h :r" and go to :[range]r[ead] [++opt] !{cmd}
    " only generate diary template if it's new file
    " http://frostyx.cz/posts/vimwiki-diary-template
    au BufNewFile ~/vimwiki/diary/*.md :silent 0r !~/.vim/bin/generate-vimwiki-diary-template.py '%'
augroup end 
" }}}

" Goyo {{{

" https://www.youtube.com/watch?v=2cIdnfT5zxA
let g:goyo_width = 90
" larger -> more contrast
let g:limelight_default_coefficient = 0.7
" highlight more than current paragraph (i.e. surrounding paragraph)
" let g:limelight_paragraph_span = 1

map <leader>gy :Goyo<CR>
map <leader>ll :Limelight!!<CR>
" When enter goyo turn on limelight, custom event handler prob handled by
" Goyo library 
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

"}}}

"Vim Airline {{{

" airline https://github.com/vim-airline/vim-airline
" airline theme: https://github.com/vim-airline/vim-airline-themes
let g:airline_theme='simple'

"}}}

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
