vim.g.mapleader = " "

-- Thanks to ThePrimeagen (https://www.youtube.com/watch?v=w7i4amO_zaE)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })

vim.keymap.set({ "n", "v" }, "p", "P", { noremap = true })
vim.keymap.set({ "n", "v" }, "gp", "`[v`]", { noremap = true })
vim.keymap.set({ "n", "v" }, "x", "d", { noremap = true })
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true })

vim.keymap.set({ "n", "v" }, "<C-w>h", ":vsplit<CR> <BAR> :wincmd h<CR>", { noremap = true })
vim.keymap.set({ "n", "v" }, "<C-w>j", ":split<CR> <BAR> :wincmd j<CR>", { noremap = true })
vim.keymap.set({ "n", "v" }, "<C-w>k", ":split<CR> <BAR> :wincmd k<CR>", { noremap = true })
vim.keymap.set({ "n", "v" }, "<C-w>l", ":vsplit<CR> <BAR> :wincmd l<CR>", { noremap = true })
vim.keymap.set({ "n", "v" }, "<C-w>c", ":tab split<CR>", { noremap = true })

-- Function to swap the current split with the next one (to the right or below)
function SwapWithNextSplit()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)
  vim.cmd('wincmd l')
  local is_horizontal = vim.api.nvim_get_current_win() ~= current_win
  if not is_horizontal then
    vim.cmd('wincmd j')
  end
  local next_win = vim.api.nvim_get_current_win()
  local next_buf = vim.api.nvim_win_get_buf(next_win)
  vim.api.nvim_win_set_buf(current_win, next_buf)
  vim.api.nvim_win_set_buf(next_win, current_buf)
end

-- Function to swap the current split with the previous one (to the left or above)
function SwapWithPrevSplit()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)
  vim.cmd('wincmd h')
  local is_horizontal = vim.api.nvim_get_current_win() ~= current_win
  if not is_horizontal then
    vim.cmd('wincmd k')
  end
  local prev_win = vim.api.nvim_get_current_win()
  local prev_buf = vim.api.nvim_win_get_buf(prev_win)
  vim.api.nvim_win_set_buf(current_win, prev_buf)
  vim.api.nvim_win_set_buf(prev_win, current_buf)
end

vim.keymap.set('n', '<C-W><S-L>', SwapWithNextSplit, { noremap = true })
vim.keymap.set('n', '<C-W><S-H>', SwapWithPrevSplit, { noremap = true })
vim.keymap.set('n', '<C-W><S-J>', SwapWithNextSplit, { noremap = true })
vim.keymap.set('n', '<C-W><S-K>', SwapWithPrevSplit, { noremap = true })
