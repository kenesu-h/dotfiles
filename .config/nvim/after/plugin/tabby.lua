local theme = {
  fill = "TabLineFill",
  head = "TabLine",
  current_tab = "TabLineSel",
  tab = "TabLine",
  win = "TabLine",
  tail = "TabLine",
}
require("tabby.tabline").set(function(line)
  return {
    line.tabs().foreach(function(tab)
      local hl = tab.is_current() and theme.current_tab or theme.tab
      return {
        line.sep("", hl, theme.fill),
        tab.is_current() and "" or "󰆣",
        tab.number(),
        tab.name(),
        tab.close_btn(""),
        line.sep("  ", hl, theme.fill),
        hl = hl,
        margin = " ",
      }
    end),
    hl = theme.fill,
  }
end)
