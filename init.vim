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

"" <C-> move
nmap <C-k> :bnext<CR>
nmap <C-j> :bprev<CR>
nmap <C-l> :wincmd w<CR>
nmap <C-h> :wincmd p<CR>

" <C-> Plugins
nmap <C-f> :ClangFormat<CR>
nmap <C-s> :SyntasticToggleMode<CR>
nmap <C-x> :SyntaxToggle<CR>

" <leader>
let mapleader = " "
" spelling
nmap <leader>s :set spell!<CR>
" buffers
nmap <leader>bc :Bdelete<CR>
nmap <leader>bd :Bdelete!<CR>
nmap <leader>bn :enew <CR>
nmap <leader>bf :Buffers<CR>
" fzf
nmap <leader>f :Files<CR>
nmap <leader>h :Files ~<CR>
nmap <leader>g :GFiles<CR>
" current word commands
nmap <leader>wg :Grep <C-r><C-w><CR>
nmap <leader>ws :%s/\<<C-r><C-w>\>/
nmap <leader>wS :%S/\<<C-r><C-w>\>/
" buffers + current word commands
nmap <leader>bws :bufdo! %s/\<<C-r><C-w>\>/
nmap <leader>bwS :bufdo! %S/\<<C-r><C-w>\>/
" access and load vimrc
nmap <leader>vr :e $MYVIMRC<cr>
nmap <leader>vs :source $MYVIMRC<cr>
" ycm
nmap <leader>yc :YcmForceCompileAndDiagnostics<CR>
nmap <leader>yg :YcmCompleter GoToDefinitionElseDeclaration<CR>

" exit terminal with ESC
tnoremap <Esc> <C-\><C-n>

" no navigating
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" commands with FZF
" ripgrep command with preview
command! -bang -nargs=* Grep
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('right:50%', '?'), <bang>0)
" add preview to Files
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
