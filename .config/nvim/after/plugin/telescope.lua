local telescope = require("telescope")

local width = 0.95
local height = 0.95

telescope.setup({
  defaults = {
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        width = width,
        height = height,
      },
      vertical = {
        width = width,
        height = height,
      },
    },
  },
  extensions = {
    file_browser = {
      grouped = true,
    },
  },
})

telescope.load_extension("file_browser")
