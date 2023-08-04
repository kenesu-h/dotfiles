require("telescope").setup({
  extensions = {
    file_browser = {
      grouped = true,
    },
  },
})

require("telescope").load_extension("file_browser")
vim.keymap.set(
  "n",
  "<leader>pb",
  require("telescope").extensions.file_browser.file_browser,
  { noremap = true }
)
