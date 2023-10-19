vim.g.mapleader = " "

-- Thanks to ThePrimeagen (https://www.youtube.com/watch?v=w7i4amO_zaE)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "p", "P")
vim.keymap.set({ "n", "v" }, "gp", "`[v`]")
vim.keymap.set({ "n", "v" }, "x", "d")
vim.keymap.set({ "n", "v" }, "d", '"_d')

vim.keymap.set({ "n", "v" }, "<C-w>h", ":vsplit<CR> <BAR> :wincmd h<CR>")
vim.keymap.set({ "n", "v" }, "<C-w>j", ":split<CR> <BAR> :wincmd j<CR>")
vim.keymap.set({ "n", "v" }, "<C-w>k", ":split<CR> <BAR> :wincmd k<CR>")
vim.keymap.set({ "n", "v" }, "<C-w>l", ":vsplit<CR> <BAR> :wincmd l<CR>")
