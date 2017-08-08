" Remove mouse support
set mouse

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

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

set shortmess=at
set shell=bash
set autoindent
set smartindent
set incsearch                                  " Highlight the incremental search
set hlsearch                                   " Highlight the matches of search
set ignorecase                                 " Case-insensitive searching
set backspace=2                                " Allow backspace key to erase previously entered characters
set hidden                                     " Allow hidden buffers
set previewheight=15                           " Increase the Fugitive Gstatus window
set autoread                                   " Automatically refresh any unchanged files

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
" You also need to install
" pip2 --no-cache-dir install -U neovim
" And make shure that :echo has('python') returns 1
Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'jasoncodes/ctrlp-modified.vim'

" Colorscheme
Plugin 'gosukiwi/vim-atom-dark'
Plugin 'tomasr/molokai'
Plugin 'zeis/vim-kolor'
Plugin 'mhartington/oceanic-next'
Plugin 'w0ng/vim-hybrid'
Plugin 'kristijanhusak/vim-hybrid-material'

Plugin 'scrooloose/nerdtree'
let g:NERDTreeDirArrows = 0
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic.git'

Plugin 'KabbAmine/zeavim.vim'
let g:zv_zeal_executable = '/Applications/Zeal.app/Contents/MacOS/Zeal'
let g:zv_docsets_dir = '/Users/felipenavas/Library/Application Support/Zeal/Zeal/docsets'
let g:zv_file_types = {
            \ 'ruby': 'ruby 2,ruby on rails 3',
            \ 'javascript': 'backbonejs,javascript,underscore,marionettejs'
        \ }
let g:zv_disable_mapping = 1
nmap gzz <Plug>Zeavim
vmap gzz <Plug>ZVVisSelection
nmap gz <Plug>ZVMotion
nmap gZ <Plug>ZVKeyDocset

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'gregsexton/gitv'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-abolish'
Plugin 'vim-scripts/tComment'
Plugin 'bogado/file-line'
Plugin 'airblade/vim-gitgutter'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'chrisbra/vim-diff-enhanced'
Plugin 'tpope/vim-surround'
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'janko-m/vim-test'
let test#strategy = "neovim"
let g:test#preserve_screen = 1

Plugin 'easymotion/vim-easymotion'
Plugin 'bronson/vim-visual-star-search'

map <leader><Leader>l <Plug>(easymotion-lineforward)
map <Leader><leader>j <Plug>(easymotion-j)
map <Leader><leader>k <Plug>(easymotion-k)
map <Leader><leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

Plugin 'rking/ag.vim'
Plugin 'majutsushi/tagbar'

Plugin 'terryma/vim-multiple-cursors'

Plugin 'junegunn/vim-easy-align'
Plugin 'vim-scripts/lastpos.vim'
Plugin 'tommcdo/vim-exchange'

Plugin 'vim-scripts/SQLUtilities'
Plugin 'vim-scripts/Align'
Plugin 'Zuckonit/vim-airline-tomato'

let g:tomato#show_clock = 1
let g:tomato#show_count_down = 1
let g:tomato#interval = 60 * 45
let g:tomato#rest_time = 60 * 5

Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'

let g:gist_show_privates = 1

"Plugin 'vim-javascript'
"Plugin" 'ternjs/tern_for_vim'
"https://github.com/Valloric/YouCompleteMe
"https://github.com/garbas/vim-snipmate

"Plugin 'ntpeters/vim-better-whitespace'
"Plugin 'emmet-vim'
"Plugin 'vim-git'
"Plugin 'vim-javascript'
"Plugin 'vim-ruby'
"Plugin 'vim-rubocop'
"Plugin 'vim-ruby-complexity'
"Plugin 'vim-ruby-debugger'

Plugin 'mbbill/undotree'
if has("persistent_undo")
    set undodir=~/.cache/.undodir/
    set undofile
endif

if vundle_installed == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :VundleInstall
endif


" All of your Plugins must be added before the following line
call vundle#end()         " required
filetype plugin indent on

if has('nvim')
  :tnoremap <C-w>h <C-\><C-n><C-w>h
  :tnoremap <C-w>j <C-\><C-n><C-w>j
  :tnoremap <C-w>k <C-\><C-n><C-w>k
  :tnoremap <C-w>l <C-\><C-n><C-w>l
  :tnoremap <C-w><Left> <C-\><C-n><C-w>h
  :tnoremap <C-w><Down> <C-\><C-n><C-w>j
  :tnoremap <C-w><Up> <C-\><C-n><C-w>k
  :tnoremap <C-w><Right> <C-\><C-n><C-w>l
  :tnoremap <C-w><C-w> <C-\><C-n><C-w><C-w>
  :tnoremap <Esc><Esc> <C-\><C-n>
  nnoremap <leader>z :terminal<CR>source /etc/bashrc<CR>source $HOME/.bash_profile<CR>clear<CR>
endif

let g:terminal_scrollback_buffer_size=100000

"fun! DdeleteOrQuitIfLast()
"    bdelete
"    let bufcnt = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
"    if bufcnt < 2
"        quit
"    endif
"endfun

"cabbrev q bdelete
cabbrev q close

"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>

"colorscheme molokai
"colorscheme atom-dark-256
colorscheme OceanicNext
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
"let g:airline_theme="molokai"
let g:airline_theme='oceanicnext'
"let g:airline_theme=powerlineish

" CtrlP config
let g:ctrlp_map = '<leader>t'
"nnoremap <leader>t <Esc>:CtrlP<CR>
nnoremap <leader>b <Esc>:CtrlPBuffer<CR>
nnoremap <leader>m <Esc>:CtrlPMRU<CR>
"let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:ctrlp_match_func = { 'match' : 'matcher#cmatch' }
let g:ctrlp_match_window = 'min:4,max:72'
" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.sass-cache$|\.hg$\|\.svn$\|\.yardoc\|public$|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }
if(isdirectory(expand(getcwd() . "/.git")))
  let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
  let g:ctrlp_user_command = ['.git/', 'git ls-files --cached --others  --exclude-standard %s']
else
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

"Delete closed fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Jump to last cursor position
"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Hack for visual selection highlight work properly in vim
"hi Visual cterm=reverse

" Highlights for Ident Guides Plugin
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
"let g:indent_guides_color_change_percent = 90
hi IndentGuidesOdd  guibg=#070707 ctermbg=234
hi IndentGuidesEven guibg=#1a1a1a ctermbg=236
"<SNR>10_IndentGuidesEnable[1]..indent_guides#enable[3]..indent_guides#init_script_vars[3]..indent_guides#capture_highlight:

" Highlight the current cursor line
set cursorline
hi CursorLine term=underline ctermbg=236 guibg=#121212

" Ggrep
if(isdirectory(expand(getcwd() . "/.git")))
  nnoremap <leader>g <Esc>:execute "Ggrep '" . expand("<cword>") . "'"<CR>
else
  nnoremap <leader>g <Esc>:execute "Ag '" . expand("<cword>") . "'"<CR>
endif
autocmd QuickFixCmdPost *grep* cwindow

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
"call CtagFunc()

"command! Ctags :! expand(s:ctag_command)
command! CtagsBackground :call CtagFunc()<CR>

" Shortcut to save and run the rspec tests
nnoremap <silent> <leader>R :TestFile<CR>
nnoremap <silent> <leader>r :TestSuite<CR>
nnoremap <silent> <leader>l :TestLast<CR>
nnoremap <silent> <leader><C-R> :TestNearest<CR>
nnoremap <silent> <leader>® :TestVisit<CR>

" nnoremap <leader>r <Esc>:w<CR>:! clear;rspec<CR>
" nnoremap <leader>R <Esc>:w<CR>:call RspecSingle()<CR>
" nnoremap <leader><C-R> <Esc>:w<CR>:call RSpecCurrent()<CR>

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
  execute "split term://source /etc/bashrc;source $HOME/.bash_profile;clear;" . DetectZeus() . " rspec --color " . g:rspec_last_current
  "make!
  "cw
  "cc
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

nnoremap <leader>" :call ChangeQuotes()<CR>

func! ChangeQuotes()
  if getline('.') =~ '"'
    exe "s/\"/'/g"
  else
    if getline('.') =~ ''''
      exe "s/'/\"/g"
    endif
  endif
endfunction

" Ejs support
au BufNewFile,BufRead *.ejs set filetype=html

au FileType qf call AdjustWindowHeight(1, 10)
function! AdjustWindowHeight(minheight, maxheight)
   let l = 1
   let n_lines = 0
   let w_width = winwidth(0)
   while l <= line('$')
       " number to float for division
       let l_len = strlen(getline(l)) + 0.0
       let line_width = l_len/w_width
       let n_lines += float2nr(ceil(line_width))
       let l += 1
   endw
   exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Syntastic
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_ruby_checkers = ['mri', 'rubocop', 'reek']
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['javascript'] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
