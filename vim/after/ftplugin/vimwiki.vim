" prefixing my own settings with ac...
if exists('b:ac_did_ftplugin')
  finish
endif
let b:ac_did_ftplugin = 1  " Don't load another plugin for this buffer

" $VIMWIKI_ROOT, $VIMWIKI_DIARY_ROOT are set at ~/.vimrc

command VimwikiGenerateCurrDirLinks call s:vimwiki_curr_dir_links()

" generates a list of links in current directory and first sub directory index
function s:vimwiki_curr_dir_links()
    " get current directory non-index wikis, remove ./ prefix
    let l1_files = system('find . -mindepth 1 -maxdepth 1 -not -path "*/.*" -type f | awk "!/index\.md/ && /\.md/" | cut -c 3-')
    " get immediate subdirectories index wiki
    let l2_files = system('find . -mindepth 2 -maxdepth 2 -not -path "*/.*" -type f | grep "index.md" | cut -c 3-')

    " TODO: use # title as link name
    for file in split(l1_files, "\n")
        " remove .md
        let l = "["..file[:-4].."]("..file..")"
        put! =l
    endfor
    
    for file in split(l2_files, "\n")
        " use directory name as link name
        let dir_name = split(file, "/")[0]
        let l = "["..dir_name.."]("..file..")"
        put! =l
    endfor
endfunction

function! JumpToParentIndex() abort
    let isIndex = expand('%:t') ==# "index.md"
    let parentIndex = isIndex ? findfile("index.md", "..;~/vimwiki") : findfile("index.md", ".;~/vimwiki")
    echo parentIndex
    if empty(parentIndex)
        return
    endif
    exe ":w | :e "..parentIndex
endfunction

" dictionary complete for a wiki folder. Support completion of tags and completion of file links
" arg: wiki root directory path
function! FZFDictionaryComplete(root) abort
    " check current line, if begins with tags: []
    let line = getline(".")
    let word = expand("<cword>")
    let isTag = line =~# '^tags: ['
    let isLink = word =~# '[(]\@!)*]('
    if (isTag)
        return execute("call fzf#vim#complete('cat "..a:root..".vimwiki/tags')")
    elseif (isLink)
        " find all files under root, remove root prefix, feed stdout to fzf
        let exclude = ["-path "..a:root.."diary", a:root..".obsidian", a:root..".vimwiki"] 
        let cmd = "'prefix=\""..a:root.."\" && find "..a:root.." \\( "..join(exclude, " -o -path ").." \\) -prune -o -type f -name \"*.md\" -print | while read file; do echo \"\/\"${file/#$prefix}; done'"
        return execute("call fzf#vim#complete("..cmd..")")
    else
        " return normal dictionary map expression call?
        return ''
    endif 
endfunction

augroup vim_wiki
    au! 
    " required for ultisnip to work: https://github.com/vimwiki/vimwiki/issues/357
    let g:vimwiki_table_mappings = 0

    " vimwiki defines its own filetype. merge md snippet and vimwiki snippets take precedence over md
    UltiSnipsAddFiletypes vimwiki.md
    nnoremap <C-P> :Files $VIMWIKI_ROOT<CR>
    nnoremap <leader><CR> :VimwikiTabnewLink<CR>
    " https://github.com/junegunn/fzf.vim/issues/837
    " :h user-functions -> !, replaces a function if one already exists
    command! -bang -nargs=* VimwikiRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case "..shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': $VIMWIKI_ROOT}), <bang>0)
    nnoremap <leader><C-P> :VimwikiRg 
    nnoremap <leader><BS> :call JumpToParentIndex()<CR>
    nmap <C-x> <Plug>VimwikiToggleListItem
    " let vim change the cwd for VimwikiGenerateCurrDirLinks to work
    if exists('+autochdir')
        set autochdir
    endif

    if filereadable($VIMWIKI_ROOT..".vimwiki/tags")
        inoremap <expr> <c-x><c-k> FZFDictionaryComplete($VIMWIKI_ROOT)
    endif

    function! s:try_insert(skel)
        execute "normal! i" .. a:skel .. "\<C-r>=UltiSnips#ExpandSnippet()\<CR>"
        if g:ulti_expand_res == 0
            silent! undo
        endif
        return g:ulti_expand_res
    endfunction

    function! InsertVimwikiSkeleton(diaryRoot) abort
        let filepath = expand("%:p")
        " check is a new file. Abort otherwise
        if (!(line('$') == 1 && getline('$') == '') || filereadable(filepath))
            return
        endif
        let skel = stridx(filepath, a:diaryRoot) != -1 ? "diary" : "md"
        call s:try_insert(skel)
        startinsert
    endfunction
    " source: https://noahfrederick.com/log/vim-templates-with-ultisnips-and-projectionist
    call InsertVimwikiSkeleton($VIMWIKI_DIARY_ROOT)

augroup end 

