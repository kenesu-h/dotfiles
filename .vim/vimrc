source $HOME/.vim/plugins.vim     " Load plugins first.


" GENERAL
set ff=unix                       " Use Unix line endings for files.
set encoding=utf-8                " Use UTF-8 encoding for files.

set background=dark               " Dark background.

set laststatus=2                  " Always show the status bar.
set noshowmode                    " Hide the current mode from the status line.

set textwidth=80                  " Poses a hard text width of 80 characters.
set colorcolumn=80                " Shows a word-wrap column at 80 characters.
set nowrap                        " Text will not soft-wrap.

set fillchars+=vert:\|            " Use bar characters as vertical separators.
set signcolumn=yes                " Always display the sign column.

set autoindent                    " Always autoindent.
set breakindent                   " Word-wrap indents match the previous line.
set expandtab                     " Indents are always spaces.
set shiftwidth=2                  " Indent levels are equivalent to 2 spaces.
set tabstop=2                     " Tab indents are equivalent to 2 spaces.
set lbr                           " Prevents word-wrap from splitting words.

syntax enable                     " Enable syntax highlighting.
set number                        " Enables line numbers.

set showtabline=2                 " Always show active tabs.
set clipboard+=unnamed            " Enables pasting from the system clipboard.
set backspace=indent,eol,start    " Enables backspacing like most text editors.

set spell                         " Enable spell-checking.
set spelllang=en_us               " Spell-checking checks for US English.

set showmatch                     " Highlights matching braces.
set hlsearch                      " Highlights search results.

set splitbelow                    " New splits default to a new pane below.


" AUTOCMDS
"" Resize all windows back to equal proportions if Vim is resized.
autocmd VimResized * wincmd =

"" Recognize numbered lists when formatting, and only auto-format comments.
autocmd FileType * set formatoptions=nc


" MAPPINGS
let mapleader = " "

"" esc : for returning to normal from terminal mode
tnoremap <Esc> <C-\><C-n>

"" enter: reset highlighting from search
nnoremap <CR> :noh<CR><CR>

"" n : for NERDTree (or at least, originally NERDTree).
nnoremap <leader>n :Fern %:h -drawer<CR>

"" t : for terminal
nnoremap <leader>t :term<CR>

"" e : for errors
nnoremap <leader>e :CocDiagnostics<CR>

nnoremap <leader>g :Git<CR>

"" Snippet below thanks to https://superuser.com/a/321726
"" d : for delete without yanking
nnoremap <leader>d ""_d
vnoremap <leader>d ""_d

"" replace currently selected text with default register
"" without yanking it
"" p : for paste without yanking
vnoremap <leader>p ""_dP

"" https://vi.stackexchange.com/a/10424
"" hardwraptoggle
"" i : for wrap toggle
command HardWrapToggle if &fo =~ 't' | set fo-=t | else | set fo+=t | endif
nnoremap <leader>w :HardWrapToggle<CR>
