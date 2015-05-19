syntax on
set directory=~/tmp// " solve fugitive errors
set ttyfast " u got a fast terminal
set ttyscroll=3
set lazyredraw " to avoid scrolling problems

set shell=bash
set autoindent
set smartindent
set incsearch             " Highlight the incremental search
set hlsearch              " Highlight the matches of search
set ignorecase            " Case-insensitive searching
set backspace=2           " Allow backspace key to erase previously entered characters
set hidden                " Allow hidden buffers
set previewheight=15      " Increase the Fugitive Gstatus window

syntax on

"set encoding=utf-8        " Every new file will be utf-8
"set fileformat=unix       " LF is default EOL for new files
"set fileformats=unix,dos  " Empty files will be open as Unix

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'wincent/command-t'
Plugin 'airblade/vim-gitgutter'
"Plugin 'scrooloose/syntastic.git'

" All of your Plugins must be added before the following line
call vundle#end()         " required
filetype plugin indent on

let g:ruby_debugger_no_maps = 1
let g:ruby_debugger_progname = 'mvim'
let g:ruby_debugger_debug_mode = 1
let g:ruby_debugger_servername = "vim"

call pathogen#infect()

"Always show the status bar
set laststatus=2
set nocompatible
set history=10000
let g:Powerline_symbols = 'fancy'
"set fillchars+=stl:\ ,stlnc:\

"Delete closed fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

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

" Highlight the current cursor line
set cursorline
hi CursorLine term=underline ctermbg=236 guibg=#121212

" Ggrep
nnoremap <leader>g <Esc>:execute "Ggrep '" . expand("<cword>") . "'"<CR>

" Shortcut to open Gstatus
nnoremap <leader>G <Esc>:Gstatus<CR>

" Generate Ctags
command Ctags :!/usr/local/bin/ctags -R --exclude=.git --exclude=log *

" Shortcut to save and run the rspec tests
nnoremap <leader>r <Esc>:w<CR>:! clear;rspec<CR>
nnoremap <leader>R <Esc>:w<CR>:call RspecSingle()<CR>
nnoremap <leader><C-R> <Esc>:w<CR>:call RSpecCurrent()<CR>

" Syntax Checking
"nnoremap <leader>s <Esc>:w<CR>:!ruby -c %<CR>
nnoremap <leader>s <Esc>:w<CR>:SyntasticCheck<CR>

" Complexity Checking
nnoremap <leader>C <Esc>:w<CR>:!flog -e --all %<CR>
nnoremap <leader><C-C> <Esc>:w<CR>:call ShowComplexity()<CR>

" Complexity Warning
let g:rubycomplexity_enable_at_startup = 0
let g:rubycomplexity_medium_limit = 22
let g:rubycomplexity_high_limit = 60

function! LoadAndDisplayRSpecQuickfix()
  let quickfix_filename = ".git/quickfix.out"
  if filereadable(quickfix_filename) && getfsize(quickfix_filename) != 0
    silent execute ":cfile " . quickfix_filename
    botright cwindow
    cc
  else
    redraw!
    echohl WarningMsg | echo "Quickfix file " . quickfix_filename . " is missing or empty." | echohl None
  endif
endfunction

noremap <Leader>q :call LoadAndDisplayRSpecQuickfix()<CR>

func! RSpecCurrent()
  if expand('%:t') =~ "_spec.rb"
    let g:rspec_last_current = expand("%p") . ":" . line(".")
  endif
  execute "compiler rspec | set makeprg=(clear\\ &&\\ " . DetectZeus() . "\\ rspec\\ --color\\ " . g:rspec_last_current . ")"
  make!
  cw
  cc
endfunc

func! RspecSingle()
  if expand('%:t') =~ "_spec.rb"
    let g:rspec_last_single = expand("%p")
  endif
  execute "compiler rspec | set makeprg=(clear\\ &&\\ " . DetectZeus() . "\\ rspec\\ --color\\ " . g:rspec_last_single . ")"
  make!
  cw
  cc
endfunc

func! DetectZeus()
  echo "Zeus Detected!"
  return system("if [ -S '.zeus.sock' ]; then echo -n zeus; fi")
endfunc

" Shortcut to rapidly toggle line numbers
nnoremap <leader>n :set number!<CR>
nnoremap <leader>N :set relativenumber!<CR>
noremap  <leader>C-N :GitGutterToggle<CR>

nnoremap <leader>w :echo bufname("%")<CR>

" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>
set listchars=eol:¬,trail:~
set ts=2 sts=2 sw=2 expandtab

" Highlight for the set list chars
highlight NonText guifg=#242 ctermfg=61

" Save as root
command Wsudo :w !sudo tee >/dev/null %

" Identations
vnoremap << <gv
vnoremap >> >gv
vnoremap = =gv

" Like Ctrl+X, Ctrl+C and Ctrl+V
" Only works after installing vim-gnome package on Ubuntu 10.04 (why?)
vnoremap <leader>x "+d
vnoremap <leader>c "+y
nnoremap <leader>v "+p
nnoremap <leader>V "+P

" Comments
vnoremap <leader># 0<c-v>I#~ <ESC>
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

func! RubySyntaxCheck()
  redir => syntaxcheck
  exe "!ruby -c %"
  exe "redraw!"
  redir END
  echom syntaxcheck
endfunc

autocmd FileType ruby  :autocmd BufWrite * :call PeaceOfMind() "| call RubySyntaxCheck()
autocmd FileType eruby :autocmd BufWrite * :call PeaceOfMind()
autocmd FileType html  :autocmd BufWrite * :call PeaceOfMind()
autocmd FileType yaml  :autocmd BufWrite * :call PeaceOfMind()
autocmd FileType scss  :autocmd BufWrite * :call PeaceOfMind()
autocmd FileType ruby,eruby
      \ set foldmethod=expr |
      \ set foldexpr=getline(v:lnum)=~'^\\s*#' |
      \ set foldlevelstart=99 |
      \ set foldlevel=999

" Spell Checking for Yaml
autocmd FileType yaml,markdown setlocal spell
autocmd BufRead,BufWrite .git/COMMIT_EDITMSG setlocal spell
autocmd BufRead,BufNewFile */config/locales/*.yml call SetI18nFileSpellLang()

func! I18nMode()
  windo setlocal scrollbind | setlocal cursorbind | setlocal cursorline
  windo noremap <buffer> j <Down><C-w><C-w><C-w><C-w>
  windo noremap <buffer> k <Up><C-w><C-w><C-w><C-w>
endfunction
command I18nMode :call I18nMode()

func! SetI18nFileSpellLang()
  let l:filelocale = matchlist(expand("%"), '\v(\l{2}(-\u{2})?)\.yml')[1]
  let l:vimlocale = join(split(tolower(filelocale), "-"), "_")
  let &spelllang=l:vimlocale
endfunction

" Ejs support
au BufNewFile,BufRead *.ejs set filetype=html

noremap <leader>db  :call ruby_debugger#load_debugger() <bar> call g:RubyDebugger.toggle_breakpoint()<CR>
noremap <leader>dv  :call ruby_debugger#load_debugger() <bar> call g:RubyDebugger.open_variables()<CR>
noremap <leader>dm  :call ruby_debugger#load_debugger() <bar> call g:RubyDebugger.open_breakpoints()<CR>
noremap <leader>dt  :call ruby_debugger#load_debugger() <bar> call g:RubyDebugger.open_frames()<CR>
noremap <leader>ds  :call ruby_debugger#load_debugger() <bar> call g:RubyDebugger.step()<CR>
noremap <leader>df  :call ruby_debugger#load_debugger() <bar> call g:RubyDebugger.finish()<CR>
noremap <leader>dn  :call ruby_debugger#load_debugger() <bar> call g:RubyDebugger.next()<CR>
noremap <leader>dc  :call ruby_debugger#load_debugger() <bar> call g:RubyDebugger.continue()<CR>
noremap <leader>de  :call ruby_debugger#load_debugger() <bar> call g:RubyDebugger.exit()<CR>
noremap <leader>dd  :call ruby_debugger#load_debugger() <bar> call g:RubyDebugger.remove_breakpoints()<CR>

" Syntastic
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_ruby_checkers = ['mri', 'rubocop', 'reek']
let g:syntastic_mode_map = { 'mode': 'passive' }
"                          \ 'active_filetypes': ['ruby', 'javascript'] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
