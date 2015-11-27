if has('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

set directory=~/tmp// " solve fugitive errors
set ttyfast " u got a fast terminal
if !has('nvim')
    set ttyscroll=3
else
    set synmaxcol=2048
endif
set lazyredraw " to avoid scrolling problems

set shell=bash
set autoindent
set smartindent
set incsearch                                  " Highlight the incremental search
set hlsearch                                   " Highlight the matches of search
set ignorecase                                 " Case-insensitive searching
set backspace=2                                " Allow backspace key to erase previously entered characters
set hidden                                     " Allow hidden buffers
set previewheight=15                           " Increase the Fugitive Gstatus window

"let mapleader = '\'                           " Default is \
"let maplocalleader = '\'                      " Default is \
"set timeout timeoutlen=10000 ttimeoutlen=250  " Magic

syntax on

"set encoding=utf-8        " Every new file will be utf-8
"set fileformat=unix       " LF is default EOL for new files
"set fileformats=unix,dos  " Empty files will be open as Unix

if has('nvim')
    let s:editor_root=expand("~/.nvim")
else
    let s:editor_root=expand("~/.vim")
endif

" Setting up Vundle - the vim plugin bundler
let vundle_installed=1
let vundle_base=s:editor_root . '/bundle/Vundle.vim'
let vundle_readme=vundle_base . '/README.md'
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent call mkdir(s:editor_root . '/bundle', "p")
    silent execute "!git clone https://github.com/VundleVim/Vundle.vim " . vundle_base
    let vundle_installed=0
endif
let &rtp = &rtp . ',' . vundle_base
call vundle#rc(s:editor_root . '/bundle')

"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'
" You need to compile it! RTFM
Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'jasoncodes/ctrlp-modified.vim'

" Colorscheme
Plugin 'tomasr/molokai'
Plugin 'zeis/vim-kolor'

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic.git'

Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'chrisbra/vim-diff-enhanced'
Plugin 'tpope/vim-surround'
Plugin 'severin-lemaignan/vim-minimap'

Plugin 'easymotion/vim-easymotion'
Plugin 'rking/ag.vim'
Plugin 'majutsushi/tagbar'

Plugin 'terryma/vim-multiple-cursors'
" ntpeters/vim-better-whitespace"


"Plugin 'emmet-vim'
"Plugin 'vim-git'
"Plugin 'vim-javascript'
"Plugin 'vim-ruby'
"Plugin 'vim-rubocop'
"Plugin 'vim-ruby-complexity'
"Plugin 'vim-ruby-debugger'

if vundle_installed == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :VundleInstall
endif

" All of your Plugins must be added before the following line
call vundle#end()         " required
filetype plugin indent on

colorscheme molokai
"hi DiffAdd    ctermfg=233 ctermbg=194 guifg=#003300 guibg=#DDFFDD gui=none cterm=none
"hi DiffChange ctermbg=255  guibg=#ececec gui=none   cterm=none
"hi DiffText   ctermfg=233  ctermbg=189  guifg=#000033 guibg=#DDDDFF gui=none cterm=none
"hi DiffDelete ctermfg=252 ctermbg=224   guifg=#DDCCCC guibg=#FFDDDD gui=none    cterm=none
"hi DiffAdd   ctermbg=NONE ctermfg=46  cterm=NONE guibg=NONE guifg=#00FF00 gui=NONE
"hi DiffDelete ctermbg=NONE ctermfg=196 cterm=NONE guibg=NONE guifg=#FF0000 gui=NONE
"hi DiffChange xxx ctermfg=181 ctermbg=239 guifg=#89807D guibg=#4C4745
"hi DiffDelete xxx ctermfg=162 ctermbg=53 gui=bold guifg=#960050 guibg=#1E0010
"hi DiffText   xxx cterm=bold ctermbg=102 gui=bold,italic guibg=#4C4745
"hi link DiffLine String
"hi link DiffSubname Normal
"
"hi DiffAdd guifg=#00ff00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=10 ctermbg=NONE cterm=NONE
"hi DiffChange guifg=NONE guibg=#ffffff guisp=#000000 gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
"hi DiffDelete guifg=#ff0000 guibg=#000000 guisp=#000000 gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
"hi DiffText guifg=NONE guibg=#000000 guisp=#000000 gui=bold,italic ctermfg=NONE ctermbg=NONE cterm=bold

" Selected Line Color
hi Visual cterm=reverse

"Always show the status bar
set laststatus=2
set history=10000
let g:airline_powerline_fonts = 1
let g:airline_theme="molokai"
"let g:airline_theme=powerlineish

" CtrlP config
let g:ctrlp_map = '<leader>t'
"nnoremap <leader>t <Esc>:CtrlP<CR>
nnoremap <leader>b <Esc>:CtrlPBuffer<CR>
nnoremap <leader>m <Esc>:CtrlPMRU<CR>
let g:ctrlp_match_func = { 'match' : 'matcher#cmatch' }
let g:ctrlp_match_window = 'min:4,max:72'

"Delete closed fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Jump to last cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Hack for visual selection highlight work properly in vim
"hi Visual cterm=reverse

" Highlights for Ident Guides Plugin
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  guibg=#070707 ctermbg=234
hi IndentGuidesEven guibg=#1a1a1a ctermbg=236

" Highlight the current cursor line
set cursorline
hi CursorLine term=underline ctermbg=236 guibg=#121212

" Ggrep
if(isdirectory(expand(getcwd() . "/.git")))
  nnoremap <leader>g <Esc>:execute "Ggrep '" . expand("<cword>") . "'"<CR>
else
  nnoremap <leader>g <Esc>:execute "Ag '" . expand("<cword>") . "'"<CR>
endif


" Shortcut to open Gstatus
nnoremap <leader>G <Esc>:Gstatus<CR>

" Generate Ctags
"
let s:ctag_command="/usr/local/bin/ctags -R --exclude=.git --exclude=log *"
function! CtagFunc()
  let s:ctag_command="/usr/local/bin/ctags -R --exclude=.git --exclude=log *"
    let l:enabled_folders = ["runrunit", "runrunit-master"]
    let l:current_folder = split(getcwd(), '/')[-1]
    if index( enabled_folders, current_folder ) > -1
      silent execute ":!tmux new -d " . "\"". s:ctag_command . "\""
    endif
endfunction
call CtagFunc()

"command! Ctags :! expand(s:ctag_command)
command! CtagsBackground :call CtagFunc()<CR>

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

" GitGutter
let g:gitgutter_max_signs=10000
noremap  <leader>C-N :GitGutterToggle<CR>

" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>
set listchars=eol:¬,trail:~
set ts=2 sts=2 sw=2 expandtab

" Highlight for the set list chars
highlight NonText guifg=#242 ctermfg=61

" Save as root
command! Wsudo :w !sudo tee >/dev/null %

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

autocmd FilterWritePre * if &diff | setlocal wrap< | endif

autocmd FileType ruby  :autocmd BufWrite * :call PeaceOfMind() "| call RubySyntaxCheck()
autocmd FileType eruby :autocmd BufWrite * :call PeaceOfMind()
autocmd FileType html  :autocmd BufWrite * :call PeaceOfMind()
autocmd FileType yaml  :autocmd BufWrite * :call PeaceOfMind()
autocmd FileType scss  :autocmd BufWrite * :call PeaceOfMind()
autocmd FileType javascript :autocmd BufWrite * :call PeaceOfMind()
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
command! I18nMode :call I18nMode()

func! SetI18nFileSpellLang()
  let l:filelocale = matchlist(expand("%"), '\v(\l{2}(-\u{2})?)\.yml')[1]
  let l:vimlocale = join(split(tolower(filelocale), "-"), "_")
  let &spelllang=l:vimlocale
endfunction

" Ejs support
au BufNewFile,BufRead *.ejs set filetype=html

" Syntastic
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_ruby_checkers = ['mri', 'rubocop', 'reek']
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['javascript'] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
