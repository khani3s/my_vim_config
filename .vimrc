set autoindent
set smartindent
set incsearch     " Highlight the incremental search
set hlsearch      " Highlight the matches of search
set ignorecase    " Case-insensitive searching

colorscheme ir_black 
if !has("gui_running")
  silent! exec "so ~/.vim/plugin-manual-load/colorsupport.vim"
endif

" Hack for visual selection highlight work properly in vim
hi Visual cterm=reverse

" Highlights for Ident Guides Plugin
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  guibg=#070707 ctermbg=234
hi IndentGuidesEven guibg=#1a1a1a ctermbg=236

" Shortcut to run save and run the current file
nmap <leader>r <Esc>:w<CR>:! ./%<CR>

" Shortcut to rapidly toggle line numbers
nmap <leader>n :set number!<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
set listchars=eol:¬
set ts=2 sts=2 sw=2 expandtab
" Highlight for the set list chars
highlight NonText guifg=#242 ctermfg=61

" Save as root
command Wsudo :w !sudo tee >/dev/null %

" Identations
vmap << <gv
vmap >> >gv
vmap = =gv

" Ctrl+X, Ctrl+C and Ctrl+V
vmap <leader>x "+d
vmap <leader>c "+y
map <leader>v "+p
map <leader>V "+P

" Enable ragtag
let g:ragtag_global_maps = 1

" Hack for show the cursor correctly
if has("gui_running")
  hi Cursor guibg=fg
endif
