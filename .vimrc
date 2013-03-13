syntax on
set shell=bash
set autoindent
set smartindent
set incsearch             " Highlight the incremental search
set hlsearch              " Highlight the matches of search
set ignorecase            " Case-insensitive searching
set backspace=2           " Allow backspace key to erase previously entered characters
set hidden                " Allow hidden buffers

syntax on
filetype plugin indent on

set encoding=utf-8        " Every new file will be utf-8
set fileformat=unix       " LF is default EOL for new files
set fileformats=unix,dos  " Empty files will be open as Unix

call pathogen#infect()

colorscheme ir_black 
if !has("gui_running")
  colorscheme ir_black_term
endif

" Jump to last cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Hack for visual selection highlight work properly in vim
hi Visual cterm=reverse

" Highlights for Ident Guides Plugin
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  guibg=#070707 ctermbg=234
hi IndentGuidesEven guibg=#1a1a1a ctermbg=236

" Shortcut to run save and run the current file
nnoremap <leader>r <Esc>:w<CR>:! ./%<CR>
nnoremap <leader>R <Esc>:w<CR>:! rspec %<CR>

" Shortcut to rapidly toggle line numbers
nnoremap <leader>n :set number!<CR>

nnoremap <leader>w :echo bufname("%")<CR>

" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>
set listchars=eol:¬
set ts=2 sts=2 sw=2 expandtab

" Highlight for the set list chars
highlight NonText guifg=#242 ctermfg=61

" Save as root
command Wsudo :w !sudo tee >/dev/null %

" Identations
vnoremap << <gv
vnoremap >> >gv
vnoremap = =gv

" Ctrl+X, Ctrl+C and Ctrl+V
" Only works after installing vim-gnome package on Ubuntu 10.04 (why?)
vnoremap <leader>x "+d
vnoremap <leader>c "+y
nnoremap <leader>v "+p
nnoremap <leader>V "+P

" Comments
vnoremap <leader># <c-v>I#~ <ESC>
vnoremap <leader>3 :s/^#\~ //<CR><ESC> 

" Enable ragtag
let g:ragtag_global_maps = 1

" Hack for show the cursor correctly
if has("gui_running")
  hi Cursor guibg=fg
endif

" Disable stop output control 
inoremap <C-s> <C-o>:update<cr>

" Open vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>es :source $MYVIMRC<cr>

"Grep
let Grep_Default_Options = '-i' 

" Kill those f***ing white spaces, EOL, retab, fix encondig and ident the code!
func! PeaceOfMind()
  exe "normal mz"
  %s/\s\+$//ge
  %s/\s\+$//ge
  exe "normal `z"
  exe "set fenc=utf-8"
  exe "set ff=unix"
  exe "retab"
" exe "normal gg=G"
endfunc

autocmd FileType ruby  :autocmd BufWrite * :call PeaceOfMind()
autocmd FileType eruby :autocmd BufWrite * :call PeaceOfMind()
autocmd FileType html  :autocmd BufWrite * :call PeaceOfMind()
autocmd FileType yaml  :autocmd BufWrite * :call PeaceOfMind()
