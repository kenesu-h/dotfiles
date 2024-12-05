--- @module "hydras.project"
local project = {}

local util = require("hydras.util")

local builtin = require("telescope.builtin")

--- @type fun():nil
project.hydra = util.activator(util.base_hydra(
  "Project",
  [[
_f_: files
_g_: grep
_s_: symbols
_r_: resume

_y_: yank current path

_<Esc>_
]],
  nil,
  {
    { "f", builtin.find_files },
    { "g", builtin.live_grep },
    {
      "s",
      function()
        vim.ui.input({ prompt = "Workspace symbols: " }, function(query)
          builtin.lsp_workspace_symbols({ query = query })
        end)
      end,
    },
    { "r", builtin.resume },
    {
      "y",
      function()
        vim.fn.setreg("*", vim.api.nvim_buf_get_name(0))
      end,
    },
  }
))

return project
