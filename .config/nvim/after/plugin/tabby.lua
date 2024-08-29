local rose_pine = require("rose-pine.palette")

local TabbyColors = {
  TabLine = { bg = rose_pine.none },
  TabLineIcon = { fg = rose_pine.subtle },
  TabLineWorkspace = { fg = rose_pine.rose },
  TabLineTab = { fg = rose_pine.iris },
  TabLineTabSel = { fg = rose_pine.gold },
  TabLineArrow = { fg = rose_pine.pine },
}

-- https://github.com/nanozuki/tabby.nvim/issues/125#issuecomment-1732478581
local function tab_modified(tab)
  local wins = require("tabby.module.api").get_tab_wins(tab)
  for _, x in pairs(wins) do
    if vim.bo[vim.api.nvim_win_get_buf(x)].modified then
      return true
    end
  end

  return false
end

require("tabby.tabline").set(function(line)
  ---@diagnostic disable-next-line: undefined-field
  local branch = vim.b.gitsigns_head or ""

  return {
    {
      { "  " },
      { vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " " },
    },
    branch ~= "" and {
      {
        "  ",
        hl = TabbyColors.TabLineIcon,
      },
      {
        branch .. " ",
        hl = TabbyColors.TabLineWorkspace,
      },
    } or {},
    line.tabs().foreach(function(tab)
      local base_hl = tab.is_current() and TabbyColors.TabLineTabSel or TabbyColors.TabLineTab
      return {
        { tab.number() == 1 and "" or " ", hl = TabbyColors.TabLineArrow },
        { tab.number() .. ":" .. tab.name() .. (tab_modified(tab.id) and " ●  " or "") .. " ", hl = base_hl },
        hl = base_hl,
      }
    end),
    hl = TabbyColors.TabLine,
  }
end)
