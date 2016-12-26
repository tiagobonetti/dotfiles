call plug#begin('~/.config/nvim/plugged')
" small functions
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-unimpaired'
Plug 'tomtom/tcomment_vim'
Plug 'arecarn/crunch.vim'
Plug 'godlygeek/tabular'
" Visuals
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'BoltsJ/syntoggle.vim'
Plug 'iCyMind/NeoSolarized'
"Plug 'Samuel-Phillips/nvim-colors-solarized'
"Plug 'altercation/vim-colors-solarized'
" Navigation
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'moll/vim-bbye'
Plug 'rking/ag.vim'
" Auto complete
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator'
" ctags
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
" cpp
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rhysd/vim-clang-format'
" python
Plug 'hynek/vim-python-pep8-indent'
Plug 'nvie/vim-flake8'
Plug 'scrooloose/syntastic'
Plug 'davidhalter/jedi'
" json
Plug 'elzr/vim-json'
call plug#end()

" appearance
set background=dark
colorscheme NeoSolarized
"colorscheme solarized
set termguicolors

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

" Indentation
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Makefiles
autocmd FileType make setlocal noexpandtab

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#fnamemod = ':t'

" syntoggle
let g:syntoggle_syn_on = 1

" Ctrl+P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = { 'dir':  '\v[\/]\.(git|hg|svn|__pycache__)$',
                            \ 'file': '\v\.(exe|so|dll|pyc)$',
                            \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
                            \ }
autocmd CompleteDone * pclose

" NerdTree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Tagbar
let g:tagbar_left = 0

" Easytags
let g:easytags_async = 1
let g:easytags_syntax_keyword = 'always'
let g:easytags_auto_highlight = 0

" YCM
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_min_num_of_chars_for_completion = 0
let g:ycm_complete_in_strings = 1
let g:ycm_path_to_python_interpreter="/usr/bin/python"
let g:ycm_filetype_blacklist = { 'gitcommit': 1,
                               \ 'tagbar':    1,
                               \ 'qf':        1,
                               \ 'notes':     1,
                               \ 'markdown':  1,
                               \ 'unite':     1,
                               \ 'text':      1,
                               \ 'vimwiki':   1,
                               \ 'pandoc':    1,
                               \ 'infolog':   1,
                               \ 'mail':      1
                               \}
let g:ycm_show_diagnostics_ui = 1
let g:ycm_error_symbol = "✗"
let g:ycm_warning_symbol = "⚠"

" syntastic
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': []
                           \}
let g:syntastic_python_python_exec = '/path/to/python3'
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_checkers=['cppcheck']

" Cpp
let g:cpp_class_scope_highlight = 1

" clang
let g:clang_format#command = "clang-format-3.7"
autocmd FileType c,cpp let g:clang_format#auto_format = 0
let g:clang_format#code_style = "Google"
let g:clang_format#style_options = { "Standard" : "C++11", "ColumnLimit" : 0 }

" <C-> move
nmap <C-k> :bnext<CR>
nmap <C-j> :bprev<CR>
nmap <C-l> :wincmd w<CR>
nmap <C-h> :wincmd p<CR>
" <C-> files
nmap <C-b> :CtrlPBuffer<CR>
nmap <C-n> :CtrlPMRU<CR>
nmap <C-m> :CtrlPMixed<CR>
" <C-> files
nmap <C-f> :ClangFormat<CR>
nmap <C-t> :TagbarToggle<CR>
nmap <C-g> :GitGutterToggle<CR>
nmap <C-s> :SyntasticToggleMode<CR>
nmap <C-x> :SyntaxToggle<CR>

" <leader>
let mapleader = " "
" buffers
nmap <leader>bk :bnext<CR>
nmap <leader>bj :bprev<CR>
nmap <leader>bc :Bdelete<CR>
nmap <leader>bd :Bdelete!<CR>
nmap <leader>bn :enew <CR>
nmap <leader>bl :ls<CR>

nmap <leader>c :YcmForceCompileAndDiagnostics<CR>
nmap <leader>s  :set spell!<CR>
nmap <leader>ph :CtrlP ~<CR>

" current word commands
nmap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <leader>ws :%s/<C-r><C-w>/
nmap <leader>wS :%S/<C-r><C-w>/
nmap <leader>wbs :bufdo! %s/<C-r><C-w>/
nmap <leader>wbS :bufdo! %S/<C-r><C-w>/
nmap <leader>wag :Ag <C-r><C-w><cr>

nmap <leader>/ :nohlsearch<CR>
nmap <leader>vimrc :e $MYVIMRC<cr>
nmap <leader>vims :source $MYVIMRC<cr>

" Navigating
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

