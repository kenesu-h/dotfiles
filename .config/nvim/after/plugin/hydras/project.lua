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
_f_: files     _b_: browser
_g_: grep      _t_: todo
_h_: harpoon   _m_: mark

_<Esc>_
]],
  nil,
  {
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
      "t",
      function()
        vim.cmd("TodoTelescope")
      end,
    },
    {
      "m",
      function()
        harpoon:list():append()
      end,
    },
  }
))

return project
