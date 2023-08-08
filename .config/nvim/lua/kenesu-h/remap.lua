vim.g.mapleader = " "

-- thanks to ThePrimeagen (https://www.youtube.com/watch?v=w7i4amO_zaE)
vim.keymap.set("v", "N", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "B", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "p", '"0p`]')
vim.keymap.set("v", "p", '"0p`]')
vim.keymap.set("n", "x", "d")
vim.keymap.set("v", "x", "d")
vim.keymap.set("n", "d", '"_d')
vim.keymap.set("v", "d", '"_d')
