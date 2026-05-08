-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Buffer navigation (matching your old <c-j/k> workflow)
map("n", "<c-k>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<c-j>", "<cmd>bprev<cr>", { desc = "Previous Buffer" })

-- Terminal mode: ESC to exit
map("t", "<esc>", [[<c-\><c-n>]], { desc = "Exit Terminal Mode" })

-- Spelling toggle
map("n", "<leader>us", function()
  vim.opt.spell = not vim.opt.spell:get()
  print("Spell check: " .. (vim.opt.spell:get() and "ON" or "OFF"))
end, { desc = "Toggle Spelling" })

-- Buffer delete
map("n", "<leader>bc", "<cmd>bd<cr>", { desc = "Delete Buffer (close)" })

-- Search current word with Telescope
map("n", "<leader>wg", function()
  require("telescope.builtin").grep_string()
end, { desc = "Grep current word" })

-- Substitute current word
map("n", "<leader>ws", ":%s/\\<<C-r><C-w>\\>/", { desc = "Substitute current word" })

-- Edit config
map("n", "<leader>vr", "<cmd>e ~/.config/nvim-lazy/lua/config/options.lua<cr>", { desc = "Edit LazyVim config" })
map("n", "<leader>vs", "<cmd>source $MYVIMRC<cr>", { desc = "Source config" })
