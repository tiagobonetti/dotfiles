-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Only non-default settings from your old config
opt.cursorcolumn = true -- Show vertical line at cursor column
opt.tabstop = 4 -- Tab width = 4 spaces (LazyVim default is 2)
opt.shiftwidth = 4 -- Indent width = 4 spaces (LazyVim default is 2)
opt.softtabstop = 4 -- Soft tab = 4 spaces
opt.backupcopy = "yes" -- Always copy backup (for file watchers)
