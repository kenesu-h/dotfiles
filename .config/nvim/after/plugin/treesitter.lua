local configs = require("nvim-treesitter.configs")

---@diagnostic disable-next-line: missing-fields
configs.setup({
  ensure_installed = {
    "html",
    "css",
    "javascript",
    "typescript",

    "lua",
    "python",

    "dockerfile",
    "latex",
    "json",
    "yaml",
  },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
