--- @module "hydras.window"
local tab = {}

local util = require("hydras.util")

--- @param forward boolean
--- @return nil
local function move_tab(forward)
  local error = not pcall(function()
    if forward then
      vim.cmd("+tabmove")
    else
      vim.cmd("-tabmove")
    end
  end)

  if error then
    print("Cannot move tab without any other tabs open!")
  end
end

--- @type fun():nil
tab.hydra = util.activator(util.base_hydra(
  "Tab",
  [[
_h_: move left  _l_: move right
_c_: create
_x_: close

_<Esc>_
]],
  nil,
  {
    {
      "h",
      function()
        move_tab(false)
      end,
      { exit = false },
    },
    {
      "c",
      function()
        vim.cmd("tab split")
      end,
    },
    {
      "x",
      function()
        if not pcall(function()
          vim.cmd("tabclose")
        end) then
          print("Cannot close last tab!")
        end
      end,
    },

    {
      "l",
      function()
        move_tab(true)
      end,
      { exit = false },
    },
  }
))

return tab
