--- @module "hydras.hunk"
local hunk = {}

local util = require("hydras.util")

local gitsigns = require("gitsigns")

--- @type fun():nil
hunk.hydra = util.activator(util.base_hydra(
  "Hunk",
  [[
_r_: reset  _p_: preview

_<Esc>_
]],
  nil,
  {
    { "r", gitsigns.reset_hunk },

    { "p", gitsigns.preview_hunk_inline },
  }
))

return hunk
