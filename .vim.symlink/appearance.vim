" ## Appearance
" ----------
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("termguicolors"))
 set termguicolors
endif

set background=dark
colorscheme OceanicNext

"" lightline
"let g:lightline = {
"      \ 'mode_map': {
"      \   'n' : 'N',
"      \   'i' : 'I',
"      \   'R' : 'R',
"      \   'v' : 'V',
"      \   'V' : 'V-LINE',
"      \   "\<C-v>": 'V-BLOCK',
"      \   'c' : 'COMMAND',
"      \   's' : 'SELECT',
"      \   'S' : 'S-LINE',
"      \   "\<C-s>": 'S-BLOCK',
"      \   't': 'TERMINAL',
"      \ },
"      \ 'active': {
"      \   'left': [ [ 'mode', 'paste' ],
"      \             [ 'fugitive', 'gitgutter', 'filename' ] ],
"      \   'right': [ [ 'percent', 'lineinfo' ],
"      \              [ 'syntastic' ],
"      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
"      \ },
"      \ 'component_function': {
"      \   'gitgutter': 'LightLineGitGutter',
"      \   'readonly': 'LightLineReadonly',
"      \   'modified': 'LightLineModified',
"      \   'filename': 'LightLineFilename'
"      \ },
"      \ 'separator': { 'left': '░', 'right': '░' },
"      \ 'subseparator': { 'left': '>', 'right': '' }
"      \ }
"  function! LightLineModified()
"    if &filetype == "help"
"      return ""
"    elseif &modified
"      return "+"
"    elseif &modifiable
"      return ""
"    else
"      return ""
"    endif
"  endfunction
"
"  function! LightLineReadonly()
"    if &filetype == "help"
"      return ""
"    elseif &readonly
"      return "RO"
"    else
"      return ""
"    endif
"  endfunction
"
"  function! LightLineFugitive()
"    return exists('*fugitive#head') ? fugitive#head() : ''
"  endfunction
"
"  function! LightLineGitGutter()
"    if ! exists('*GitGutterGetHunkSummary')
"          \ || ! get(g:, 'gitgutter_enabled', 0)
"          \ || winwidth('.') <= 90
"      return ''
"    endif
"    let symbols = [
"          \ g:gitgutter_sign_added,
"          \ g:gitgutter_sign_modified,
"          \ g:gitgutter_sign_removed
"          \ ]
"    let hunks = GitGutterGetHunkSummary()
"    let ret = []
"    for i in [0, 1, 2]
"      if hunks[i] > 0
"        call add(ret, symbols[i] . hunks[i])
"      endif
"    endfor
"    return join(ret, ' ')
"  endfunction
"
"  function! LightLineFilename()
"    return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
"        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
"        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
"  endfunction

