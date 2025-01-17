local actions = require("telescope.actions")
local rose_pine = require("rose-pine.palette")
local telescope = require("telescope")

local width = 0.95
local height = 0.95

local TelescopeColors = {
  TelescopeMatching = { fg = rose_pine.rose },
  TelescopeSelection = { fg = rose_pine.text, bg = rose_pine.highlight_med },
  TelescopePromptPrefix = { bg = rose_pine.overlay },
  TelescopePromptNormal = { bg = rose_pine.overlay },
  TelescopeResultsNormal = { bg = rose_pine.surface },
  TelescopePreviewNormal = { bg = rose_pine.surface },
  TelescopePromptBorder = { bg = rose_pine.overlay },
  TelescopeResultsBorder = { bg = rose_pine.surface },
  TelescopePreviewBorder = { bg = rose_pine.surface },
  TelescopePromptTitle = { bg = rose_pine.rose, fg = rose_pine.surface },
  TelescopeResultsTitle = { bg = rose_pine.foam, fg = rose_pine.surface },
  TelescopePreviewTitle = { bg = rose_pine.foam, fg = rose_pine.surface },
}

for hl, col in pairs(TelescopeColors) do
  vim.api.nvim_set_hl(0, hl, col)
end

local history_mappings = {
  ["<Up>"] = actions.cycle_history_prev,
  ["<Down>"] = actions.cycle_history_next,
}

vim.keymap.set({ "n", "v", "o" }, "/", function()
  vim.cmd("Telescope current_buffer_fuzzy_find case_mode=ignore_case")
end, {
  noremap = true,
  silent = true,
})

vim.keymap.set({ "n", "v", "o" }, "?", function()
  vim.cmd("Telescope current_buffer_fuzzy_find case_mode=ignore_case")
end, {
  noremap = true,
  silent = true,
})

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
      flip_columns = 160,
    },
    mappings = {
      n = history_mappings,
      i = history_mappings,
    },
  },
})
