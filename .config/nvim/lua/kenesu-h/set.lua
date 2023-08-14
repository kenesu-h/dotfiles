vim.opt.nu = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- https://www.reddit.com/r/neovim/comments/ry9qxi/lsp_linesnvim_show_diagnostics_using_virtual/hrntw0p/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })]])
vim.opt.updatetime = 300

vim.opt.colorcolumn = "100"
vim.opt.textwidth = 100
vim.opt.formatoptions = "jcrql"

vim.o.showmode = false

vim.opt.spell = true
vim.opt.spelllang = "en_us"
