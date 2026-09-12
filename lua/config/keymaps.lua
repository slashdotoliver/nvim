-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Move through panels with Ctrl + Arrows
map("n", "<C-Left>", "<C-w>h", { desc = "Go to the left window.", remap = true })
map("n", "<C-Down>", "<C-w>j", { desc = "Go to the down window", remap = true })
map("n", "<C-Up>", "<C-w>k", { desc = "Go to the up window", remap = true })
map("n", "<C-Right>", "<C-w>l", { desc = "Go to the right window", remap = true })

-- Resize panels with Ctrl + Shift + Arrows
map("n", "<C-S-Up>", "<cmd>resize +1<cr>", { desc = "Increase height" })
map("n", "<C-S-Down>", "<cmd>resize -1<cr>", { desc = "Decrease height" })
map("n", "<C-S-Left>", "<cmd>vertical resize -1<cr>", { desc = "Decrease width" })
map("n", "<C-S-Right>", "<cmd>vertical resize +1<cr>", { desc = "Increase width" })

-- Move through buffer within a panel
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Cycle next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Cycle previous buffer" })

-- Quick documentation
map("n", "<C-q>", function()
  vim.lsp.buf.hover()
end, { desc = "Hover Documentation" })

-- File explorer
map("n", "<C-S-E>", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })

-- Git UI
map("n", "<C-S-G>", function()
  Snacks.lazygit()
end, { desc = "Open LazyGit" })
