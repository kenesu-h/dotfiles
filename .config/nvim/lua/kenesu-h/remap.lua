vim.g.mapleader = " "

-- Thanks to ThePrimeagen (https://www.youtube.com/watch?v=w7i4amO_zaE)
vim.keymap.set("v", "J", ":m '>+1<CR>gv", { noremap = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv", { noremap = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })

vim.keymap.set({ "n", "v" }, "p", "P", { noremap = true })
vim.keymap.set({ "n", "v" }, "gp", "`[v`]", { noremap = true })
vim.keymap.set({ "n", "v", "o" }, "x", "d", { noremap = true })
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true })
