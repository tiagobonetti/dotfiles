call plug#begin('~/.config/nvim/plugged')
" small functions
Plug 'tpope/vim-sensible'    "Defaults
Plug 'tpope/vim-abolish'     "Better substitute :%S//
Plug 'tpope/vim-abolish'     "Better substitute :%S//
Plug 'tpope/vim-fugitive'    "Git wrapper :Gsplit
Plug 'tpope/vim-surround'    "Change surrounds <l>cs{(
Plug 'tpope/vim-commentary'  "Change surrounds <l>cs{(
" Visuals
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'iCyMind/NeoSolarized'
Plug 'RRethy/vim-illuminate'
Plug 'luochen1990/rainbow'
" Navigation
Plug 'moll/vim-bbye'
Plug 'justinmk/vim-dirvish'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
" Language Server Protocol support
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'lighttiger2505/deoplete-vim-lsp'
" C++
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rhysd/vim-clang-format'
" QML
Plug 'peterhoeg/vim-qml'
"Python
Plug 'psf/black', { 'branch': 'stable' }
call plug#end()

" appearance
set background=dark
colorscheme NeoSolarized

set cursorcolumn
set cursorline
set number
set nowrap

" behaviour
set splitright
set splitbelow
set showcmd
set hidden
set list
set noerrorbells
set spelllang=en
set clipboard=unnamedplus

" indentation
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" always copy the backup into the file so file-watchers can detect the change
set backupcopy=yes

" makefiles
autocmd FileType make setlocal noexpandtab

" comment with // in c/cpp
autocmd FileType c,cpp setlocal commentstring=//\ %s

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_nr_show = 1

" Rainbow braces
let g:rainbow_active = 1

" disable lsp
let g:lsp_diagnostics_enabled = 0

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Cpp
let g:cpp_class_scope_highlight = 1
" clang format
let g:clang_format#command           = "clang-format"
let g:clang_format#detect_style_file = 1

"" <c-> move
nmap <c-k> :bnext<cr>
nmap <c-j> :bprev<cr>
nmap <c-l> :wincmd w<cr>
nmap <c-h> :wincmd p<cr>

" <c-> Plugins
nmap <c-f> :ClangFormat<cr>
nmap <c-s> :SyntasticToggleMode<cr>
nmap <c-x> :SyntaxToggle<cr>

" Tab or Shift-Tab selects the next/preview option
" Enter/Esc confirm/cancels completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Esc>   pumvisible() ? "\<C-e>\<Esc>" : "\<Esc>"

" <leader>
let mapleader = " "
" spelling
nmap <leader>s :set spell!<cr>
" buffers
nmap <leader>bc :Bdelete<cr>
nmap <leader>bd :Bdelete!<cr>
nmap <leader>bn :enew <cr>
nmap <leader>bf :Buffers<cr>
" fzf
nmap <leader>f  :Files<cr>
nmap <leader>ff :Files<cr>
nmap <leader>fg :GFiles<cr>
nmap <leader>fh :Files ~<cr>
nmap <leader>fw :Files ~/lmx/ws<cr>
nmap <leader>/  :Grep 
" current word commands
nmap <leader>wg :Grep <c-r><c-w><cr>
nmap <leader>ws :%s/\<<c-r><c-w>\>/
nmap <leader>wS :%S/\<<c-r><c-w>\>/
" buffers + current word commands
nmap <leader>bws :bufdo! %s/\<<c-r><c-w>\>/
nmap <leader>bwS :bufdo! %S/\<<c-r><c-w>\>/
" access and load vimrc
nmap <leader>vr :e $MYVIMRC<cr>
nmap <leader>vs :source $MYVIMRC<cr>

" exit terminal with ESC
tnoremap <esc> <c-\><c-n>

" no navigating
inoremap <Up>    <nop>
inoremap <Down>  <nop>
inoremap <Left>  <nop>
inoremap <Right> <nop>
noremap  <Up>    <nop>
noremap  <Down>  <nop>
noremap  <Left>  <nop>
noremap  <Right> <nop>

" commands with FZF
" ripgrep command with preview
command! -bang -nargs=* Grep
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('right:50%', '?'), <bang>0)
" add preview to Files
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
