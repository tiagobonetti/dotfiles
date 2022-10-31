-- Bootstraps packer on startup if needed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  --  Small functions
  use 'tpope/vim-sensible'   -- Defaults
  use 'tpope/vim-abolish'    -- Better substitute :%S//
  use 'tpope/vim-abolish'    -- Better substitute :%S//
  use 'tpope/vim-fugitive'   -- Git wrapper :Gsplit
  use 'tpope/vim-surround'   -- Change surrounds <l>cs{(
  use 'tpope/vim-commentary' -- Change surrounds <l>cs{(
  -- Visuals
  use 'feline-nvim/feline.nvim' 
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
  use 'lewis6991/gitsigns.nvim'
  use 'iCyMind/NeoSolarized'  -- TODO: review
  use 'RRethy/vim-illuminate' -- TODO: review
  use 'luochen1990/rainbow'   -- TODO: review
  -- Navigation
  use 'moll/vim-bbye'
  use 'justinmk/vim-dirvish'
-- use'junegunn/fzf', { 'do': { -> fzf#install() } }
-- use 'junegunn/fzf.vim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.*', requires = { {'nvim-lua/plenary.nvim'} } }
  use 'jremmen/vim-ripgrep'
  -- Language Server Protocol support
  use { "williamboman/mason.nvim" }
-- use 'prabirshrestha/async.vim'
-- use 'prabirshrestha/vim-lsp'
-- use 'mattn/vim-lsp-settings'
  -- Completion
-- use 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
-- use 'lighttiger2505/deoplete-vim-lsp'
-- " C++
  use 'octol/vim-cpp-enhanced-highlight'
  use 'rhysd/vim-clang-format'
-- " QML
  use 'peterhoeg/vim-qml'
-- "Python
-- use 'psf/black', { 'branch': 'stable' } 

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- appearance
vim.opt.background = "dark"
vim.cmd([[ colorscheme NeoSolarized ]])
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.wrap = false

-- behaviour
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.showcmd = true
vim.opt.hidden = true
vim.opt.list = true
vim.opt.errorbells = false
vim.opt.spelllang = "en"
vim.opt.clipboard = "unnamedplus"

-- indentation
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- always copy the backup into the file so file-watchers can detect the change
vim.opt.backupcopy = 'yes'

-- <leader>
vim.g.mapleader = ' '

-- Makefiles
vim.cmd([[ autocmd FileType make setlocal noexpandtab ]])

-- Comment with // in c/cpp
vim.cmd([[ autocmd FileType c,cpp setlocal commentstring=//\ %s ]])

-- Initialize lua plugins
require('feline').setup()
require("bufferline").setup{}
require('gitsigns').setup()
require("mason").setup()

-- Rainbow braces
vim.g.rainbow_active = '1'

-- Disable lsp
vim.g.lsp_diagnostics_enabled = '0'

-- Use deoplete.
-- vim.cmd([[ let g:deoplete#enable_at_startup = 1 ]])

-- Cpp
vim.g.cpp_class_scope_highlight = '1'

-- Clang format
-- vim.cmd([[
-- let g:clang_format#command           = "clang-format"
-- let g:clang_format#detect_style_file = 1
-- ]])

-- <c-> move
vim.cmd([[
nmap <c-k> :bnext<cr>
nmap <c-j> :bprev<cr>
nmap <c-l> :wincmd w<cr>
nmap <c-h> :wincmd p<cr>
]])

-- <c-> Plugins
vim.cmd([[
nmap <c-f> :ClangFormat<cr>
nmap <c-s> :SyntasticToggleMode<cr>
nmap <c-x> :SyntaxToggle<cr>
]])

-- Tab or Shift-Tab selects the next/preview option
-- Enter/Esc confirm/cancels completion
vim.cmd([[
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Esc>   pumvisible() ? "\<C-e>\<Esc>" : "\<Esc>"
]])

-- Spelling
vim.cmd([[ nmap <leader>s :set spell!<cr> ]])

-- Buffers
vim.cmd([[
nmap <leader>bc :Bdelete<cr>
nmap <leader>bd :Bdelete!<cr>
nmap <leader>bn :enew <cr>
nmap <leader>bf :Buffers<cr>
]])

-- Current word commands
vim.cmd([[
nmap <leader>wg :Grep <c-r><c-w><cr>
nmap <leader>ws :%s/\<<c-r><c-w>\>/
nmap <leader>wS :%S/\<<c-r><c-w>\>/
]])

-- Buffers + current word commands
vim.cmd([[
nmap <leader>bws :bufdo! %s/\<<c-r><c-w>\>/
nmap <leader>bwS :bufdo! %S/\<<c-r><c-w>\>/
]])

-- Edit init.vim
-- TODO: figure out a simple way to reload the config
vim.cmd([[ nmap <leader>ie :e $MYVIMRC<cr> ]])

-- Exit terminal with ESC
vim.cmd([[ tnoremap <esc> <c-\><c-n> ]])

-- No navigating
vim.cmd([[
inoremap <Up>    <nop>
inoremap <Down>  <nop>
inoremap <Left>  <nop>
inoremap <Right> <nop>
noremap  <Up>    <nop>
noremap  <Down>  <nop>
noremap  <Left>  <nop>
noremap  <Right> <nop>
]])



-- Telescope: Using Lua functions
vim.cmd([[
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
]])

-- FZF
-- vim.cmd([[
-- nmap <leader>f  :Files<cr>
-- nmap <leader>ff :Files<cr>
-- nmap <leader>fg :GFiles<cr>
-- nmap <leader>fh :Files ~<cr>
-- nmap <leader>fw :Files ~/lmx/ws<cr>
-- nmap <leader>/  :Grep 
-- ]])

-- Ripgrep command with preview
-- vim.cmd([[
-- command! -bang -nargs=* Grep
--   \ call fzf#vim#grep(
--   \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
--   \   fzf#vim#with_preview('right:50%', '?'), <bang>0)
-- ]])

-- Add preview to Files
-- vim.cmd([[
-- command! -bang -nargs=? -complete=dir Files
--   \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
-- ]])
