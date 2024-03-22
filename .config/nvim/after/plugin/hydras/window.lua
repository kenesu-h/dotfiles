--- @module "hydras.window"
local window = {}

local util = require("hydras.util")

--- @type fun():nil
window.hydra = util.activator(util.base_hydra(
  "Window",
  [[
split:
_h_: left, _j_: down, _k_: up, _l_: right

_<Esc>_
]],
  nil,
  {
    {
      "h",
      function()
        vim.cmd("vsplit")
      end,
    },
    {
      "j",
      function()
        vim.cmd("split")
        vim.cmd("wincmd j")
      end,
    },
    {
      "k",
      function()
        vim.cmd("split")
      end,
    },
    {
      "l",
      function()
        vim.cmd("vsplit")
        vim.cmd("wincmd l")
      end,
    },
  }
))

return window
