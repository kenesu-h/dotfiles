call plug#begin('~/.vim/plugged')

Plug 'ghifarit53/tokyonight-vim'

Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'

Plug 'lambdalisue/glyph-palette.vim'
Plug 'lambdalisue/nerdfont.vim'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'josa42/vim-lightline-coc'

Plug 'lervag/vimtex'

call plug#end()

" COLORS
set termguicolors

let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1

colorscheme tokyonight


" VIM-STARTIFY
let g:startify_bookmarks = ['~/.vim/vimrc']


" LIGHTLINE.VIM
let g:lightline = {
  \ 'colorscheme': 'tokyonight',
  \ 'active': {
  \   'left': [ 
  \     [ 'mode', 'paste' ],
  \     [  'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ], 
  \     [ 'gitbranch', 'readonly', 'filename', 'modified' ],
  \     [ 'coc_status'  ]
  \   ],
  \   'right': [
  \     ['mylineinfo'],
  \     ['percent'],
  \     ['fileformat', 'fileencoding', 'filetype']
  \   ],
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead',
  \   'mylineinfo': 'MyLineInfo'
  \ },
  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
\ }

"" MyLineInfo - (current line) / (total line) ln : (current column)
function MyLineInfo() abort
  return line('.') . '/' . line('$') . ' ln : ' . virtcol('.')
endfunction

"" Register components
call lightline#coc#register()


" FERN.VIM
let g:fern#default_hidden = 1
let g:fern#renderer = "nerdfont"


" GLYPH_PALETTE.VIM
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END
