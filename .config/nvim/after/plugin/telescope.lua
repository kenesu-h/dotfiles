local telescope = require("telescope")

local width = 0.95
local height = 0.95

local colors = require("catppuccin.palettes").get_palette("frappe")
local TelescopeColors = {
  TelescopeMatching = { fg = colors.flamingo },
  TelescopeSelection = { fg = colors.text, bg = colors.base, bold = true },

  TelescopePromptPrefix = { bg = colors.mantle },
  TelescopePromptNormal = { bg = colors.base },
  TelescopeResultsNormal = { bg = colors.mantle },
  TelescopePreviewNormal = { bg = colors.mantle },
  TelescopePromptBorder = { bg = colors.base },
  TelescopeResultsBorder = { bg = colors.mantle },
  TelescopePreviewBorder = { bg = colors.mantle },
  TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
  TelescopeResultsTitle = { bg = colors.green, fg = colors.mantle },
  TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
}

for hl, col in pairs(TelescopeColors) do
  vim.api.nvim_set_hl(0, hl, col)
end

telescope.setup({
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
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
})

telescope.load_extension("ui-select")
