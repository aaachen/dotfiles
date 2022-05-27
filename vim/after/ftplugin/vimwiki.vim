" $VIMWIKI_ROOT, $VIMWIKI_DIARY_ROOT are set at ~/.vimrc

command VimwikiGenerateCurrDirLinks call vimwiki#custom#generate_curr_dir_links()

augroup vim_wiki
    au! 
    " vimwiki defines its own filetype. merge md snippet and vimwiki snippets take precedence over md
    UltiSnipsAddFiletypes vimwiki.md
    nnoremap <C-P> :Files $VIMWIKI_ROOT<CR>
    nnoremap <leader><CR> :VimwikiTabnewLink<CR>
    " https://github.com/junegunn/fzf.vim/issues/837
    " :h user-functions -> !, replaces a function if one already exists
    command! -bang -nargs=* VimwikiRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case "..shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': $VIMWIKI_ROOT}), <bang>0)
    nnoremap <leader><C-P> :VimwikiRg 
    nnoremap <leader><BS> :call vimwiki#custom#jump_to_parent_index()<CR>
    nmap <C-x> <Plug>VimwikiToggleListItem
    " let vim change the cwd for VimwikiGenerateCurrDirLinks to work
    if exists('+autochdir')
        set autochdir
    endif

    if filereadable($VIMWIKI_ROOT..".vimwiki/tags")
        inoremap <expr> <c-x><c-k> vimwiki#custom#fzf_dictionary_complete($VIMWIKI_ROOT)
    endif

    " source: https://noahfrederick.com/log/vim-templates-with-ultisnips-and-projectionist
    call vimwiki#custom#insert_vimwiki_skeleton($VIMWIKI_DIARY_ROOT)

    au BufWrite <buffer> call vimwiki#custom#update_front_matter()
augroup end 

