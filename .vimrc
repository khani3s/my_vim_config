set autoindent
set smartindent
colorscheme ir_black 
if !has("gui_running")
	silent! exec "so ~/.vim/plugin-manual-load/colorsupport.vim"
endif
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  guibg=#070707
hi IndentGuidesEven guibg=#1a1a1a

