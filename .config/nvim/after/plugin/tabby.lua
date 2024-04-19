local rose_pine = require("rose-pine.palette")

local TabbyColors = {
  TabLine = { bg = rose_pine.surface },
  TabLineTab = { bg = rose_pine.base },
  TabLineTabSel = { bg = rose_pine.surface },
  TabLineNumber = { fg = rose_pine.base, bg = rose_pine.foam },
  TabLineNumberSel = { fg = rose_pine.base, bg = rose_pine.rose },
}

require("tabby.tabline").set(function(line)
  return {
    { " ", hl = TabbyColors.TabLine },
    line.tabs().foreach(function(tab)
      local base_hl = tab.is_current() and TabbyColors.TabLineTabSel or TabbyColors.TabLineTab
      local number_hl = tab.is_current() and TabbyColors.TabLineNumberSel or TabbyColors.TabLineNumber
      return {
        {
          line.sep("", number_hl, TabbyColors.TabLine),
          { tab.number() .. " ", hl = number_hl },
        },
        { " " .. tab.name(), hl = base_hl },
        line.sep("  ", base_hl, TabbyColors.TabLine),
        hl = base_hl,
      }
    end),
    hl = TabbyColors.TabLine,
  }
end)
