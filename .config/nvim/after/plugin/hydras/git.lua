--- @module "hydras.git"
local git = {}

local gitsigns = require("gitsigns")
local hunk = require("hydras.hunk")
local util = require("hydras.util")

local builtin = require("telescope.builtin")

--- @type fun():nil
git.hydra = util.activator(util.base_hydra(
  "Git",
  [[
_s_: status
_h_: hunk
_b_: blame

_<Esc>_
]],
  nil,
  {
    {
      "s",
      function()
        if not pcall(builtin.git_status) then
          print("Working directory isn't a Git directory!")
        end
      end,
    },
    { "b", gitsigns.toggle_current_line_blame },
    { "h", hunk.hydra },
  }
))

return git
