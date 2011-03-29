set autoindent
set smartindent
set incsearch     " Highlight the incremental search
set hlsearch      " Highlight the matches of search
set ignorecase    " Case-insensitive searching

colorscheme ir_black 
if !has("gui_running")
  silent! exec "so ~/.vim/plugin-manual-load/colorsupport.vim"
endif
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  guibg=#070707
hi IndentGuidesEven guibg=#1a1a1a

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
nmap <leader>n :set number!<CR>
set listchars=eol:¬
highlight NonText guifg=#242
set ts=2 sts=2 sw=2 expandtab

" Save as root
cmap wsudo w !sudo tee >/dev/null %


" Identations
vmap << <gv
vmap >> >gv
vmap = =gv
