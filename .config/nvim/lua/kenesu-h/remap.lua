vim.g.mapleader = " "

local REMAP_OPTS = {
  noremap = true,
  silent = true,
}

--- @param modes string | table
--- @param lhs string
--- @param rhs string | function
local function remap(modes, lhs, rhs)
  vim.keymap.set(modes, lhs, rhs, REMAP_OPTS)
end

-- Thanks to ThePrimeagen (https://www.youtube.com/watch?v=w7i4amO_zaE)
remap("v", "J", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", true)
  vim.cmd("'<,'>m '>+1")
  vim.cmd("normal! gv")
  vim.cmd("normal! =")
  vim.cmd("normal! gv")
end)

remap("v", "K", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", true)
  vim.cmd("'<,'>m '<-2")
  vim.cmd("normal! gv")
  vim.cmd("normal! =")
  vim.cmd("normal! gv")
end)

remap("n", "<C-d>", "<C-d>zz")
remap("n", "<C-u>", "<C-u>zz")
remap("n", "n", "nzzzv")
remap("n", "N", "Nzzzv")

remap({ "n", "v" }, "p", "P")
remap({ "n", "v" }, "gp", "`[v`]")
remap({ "n", "v", "o" }, "x", "d")
remap({ "n", "v" }, "d", '"_d')
