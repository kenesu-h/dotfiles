--- @module "hydras.project"
local project = {}

local util = require("hydras.util")

local builtin = require("telescope.builtin")
local grapple = require("grapple")

--- @type fun():nil
project.hydra = util.activator(util.base_hydra(
  "Project",
  [[
_f_: files
_g_: grep

_t_: tags
_m_: mark

_y_: yank current path

_<Esc>_
]],
  nil,
  {
    { "f", builtin.find_files },
    { "g", builtin.live_grep },

    { "t", grapple.toggle_tags },
    { "m", grapple.toggle },

    {
      "y",
      function()
        vim.fn.setreg("*", vim.api.nvim_buf_get_name(0))
      end,
    },
  }
))

return project
