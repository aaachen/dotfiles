" generates a list of links in current directory and first sub directory index
function! vimwiki#custom#generate_curr_dir_links()
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

function! vimwiki#custom#jump_to_parent_index() abort
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
function! vimwiki#custom#fzf_dictionary_complete(root) abort
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

function! s:try_insert(skel)
    execute "normal! i" .. a:skel .. "\<C-r>=UltiSnips#ExpandSnippet()\<CR>"
    if g:ulti_expand_res == 0
        silent! undo
    endif
    return g:ulti_expand_res
endfunction

function! vimwiki#custom#insert_vimwiki_skeleton(diaryRoot) abort
    let filepath = expand("%:p")
    " check is a new file. Abort otherwise
    if (!(line('$') == 1 && getline('$') == '') || filereadable(filepath))
        return
    endif
    " only support autoinsert diary for now
    if (stridx(filepath, a:diaryRoot) != -1) 
        let skel = "diary"
        call s:try_insert(skel)
    endif
endfunction

function! vimwiki#custom#update_front_matter() abort
    " search in current buffer's frontmatter for update
    " currently updates: date (last modified date) with the file's write date
    let save_cursor = getcurpos()

    call cursor(1,1)

    let date_pattern = "^date: '.*'$"
    let line = search(date_pattern, 'nW')
    if line
        " Should also check only modify the search line if it's within front matter range
        " Neglecting now as not fully settled on frontmatter format
        let today = strftime("%Y-%m-%d")
        call setline(line, "date: '"..today.."'")
    endif
    
    call setpos('.', save_cursor)
endfunction

