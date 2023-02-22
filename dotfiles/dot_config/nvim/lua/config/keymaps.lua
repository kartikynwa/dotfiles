-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = require("config.util").map

vim.keymap.del({ "n" }, "<leader>l")
map({ "n" }, "<leader>L", "<cmd>:Lazy<cr>", { desc = "Lazy" })
