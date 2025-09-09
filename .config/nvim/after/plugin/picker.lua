local rose_pine = require("rose-pine.palette")
local snacks = require("snacks")

local PickerColors = {
  SnacksPicker = { bg = rose_pine.surface },
  SnacksPickerMatch = { fg = rose_pine.rose },
  SnacksPickerSelected = { fg = rose_pine.text, bg = rose_pine.highlight_med },
  SnacksPickerTitle = { bg = rose_pine.rose, fg = rose_pine.surface },
}

for hl, col in pairs(PickerColors) do
  vim.api.nvim_set_hl(0, hl, col)
end

vim.keymap.set({ "n", "v", "o" }, "/", snacks.picker.lines, {
  noremap = true,
  silent = true,
})

vim.keymap.set({ "n", "v", "o" }, "?", snacks.picker.lines, {
  noremap = true,
  silent = true,
})
