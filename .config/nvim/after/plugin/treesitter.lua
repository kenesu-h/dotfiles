require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "cpp",
    "css",
    "dockerfile",
    "go",
    "javascript",
    "json",
    "latex",
    "lua",
    "nix",
    "python",
    "rust",
    "toml",
    "typescript",
    "vue",
    "yaml",
  },

  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
