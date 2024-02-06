--- @module "hydras.project"
local project = {}

local util = require("hydras.util")

local builtin = require("telescope.builtin")
local harpoon = require("harpoon")

---@diagnostic disable-next-line: missing-parameter
harpoon:setup()

--- @type fun():nil
project.hydra = util.activator(util.base_hydra(
  "Project",
  [[
_q_: quickfix  _t_: todo

_f_: files     _b_: browser
_g_: grep      _m_: mark
_h_: harpoon 

_<Esc>_
]],
  nil,
  {
    { "q", builtin.quickfix },
    {
      "t",
      function()
        vim.cmd("TodoTelescope")
      end,
    },

    { "f", builtin.find_files },
    { "g", builtin.live_grep },
    {
      "h",
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
    },

    { "b", require("telescope").extensions.file_browser.file_browser },
    {
      "m",
      function()
        harpoon:list():append()
      end,
    },
  }
))

return project
