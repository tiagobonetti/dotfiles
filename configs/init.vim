call plug#begin('~/.config/nvim/plugged')
" small functions
Plug 'tpope/vim-abolish'     "Better substitute :%S//
Plug 'tpope/vim-fugitive'    "Git wrapper :Gsplit
Plug 'tpope/vim-surround'    "Change surrounds <l>cs{(
Plug 'tpope/vim-commentary'  "Change surrounds <l>cs{(
" Visuals
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'iCyMind/NeoSolarized'
Plug 'RRethy/vim-illuminate'
" Navigation
Plug 'moll/vim-bbye'
Plug 'justinmk/vim-dirvish'
" Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf' " replaces: 'kien/ctrlp.vim'
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep' " replaces: 'rking/ag.vim'
" Auto complete
Plug 'Valloric/YouCompleteMe'
" ctags
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
" cpp
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rhysd/vim-clang-format'
" python
Plug 'nvie/vim-flake8'
"Plug 'davidhalter/jedi'
"Plug 'scrooloose/syntastic'
" QML
Plug 'peterhoeg/vim-qml'
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

" makefiles
autocmd FileType make setlocal noexpandtab

" comment with // in c/cpp
autocmd FileType c,cpp setlocal commentstring=//\ %s

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_nr_show = 1

" Easytags
let g:easytags_async = 1
let g:easytags_syntax_keyword = 'always'
let g:easytags_auto_highlight = 0

" YCM
let g:ycm_global_ycm_extra_conf = "/home/tbonetti/.config/nvim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
let g:ycm_complete_in_comments  = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_min_num_of_chars_for_completion = 0
let g:ycm_complete_in_strings = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_path_to_python_interpreter="python"
let g:ycm_show_diagnostics_ui = 1
let g:ycm_error_symbol = "✗"
let g:ycm_warning_symbol = "⚠"
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

" syntastic
" let g:syntastic_mode_map = { 'mode': 'passive',
"                            \ 'active_filetypes': [],
"                            \ 'passive_filetypes': []
"                            \}
" let g:syntastic_python_python_exec = '/path/to/python3'
" let g:syntastic_python_checkers = ['pyflakes']
" let g:syntastic_cpp_compiler = 'clang++'
" let g:syntastic_cpp_compiler_options = ' -std=c++17 -stdlib=libstdc++'
" let g:syntastic_cpp_checkers = ['cppcheck']

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
" ycm
nmap <leader>yc :YcmForceCompileAndDiagnostics<cr>
nmap <leader>yg :YcmCompleter GoToDefinitionElseDeclaration<cr>

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
