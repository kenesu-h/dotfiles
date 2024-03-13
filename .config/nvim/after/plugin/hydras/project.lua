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
_g_: grep      _m_: mark
_h_: harpoon

_q_: quickfix  _t_: todo

_y_: yank current path

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
      "m",
      function()
        harpoon:list():append()
      end,
    },

    { "q", builtin.quickfix },
    {
      "t",
      function()
        vim.cmd("TodoTelescope")
      end,
    },

    {
      "y",
      function()
        vim.fn.setreg("*", vim.api.nvim_buf_get_name(0))
      end,
    },
  }
))

return project
