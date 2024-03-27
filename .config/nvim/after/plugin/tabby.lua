local colors = require("catppuccin.palettes").get_palette("mocha")

local TabbyColors = {
  TabLine = { bg = colors.crust },
  TabLineTab = { bg = colors.surface0 },
  TabLineTabSel = { bg = colors.crust },
  TabLineNumber = { fg = colors.base, bg = colors.blue },
  TabLineNumberSel = { fg = colors.base, bg = colors.peach },
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
