package.path = vim.fn.stdpath("config") .. "/after/plugin/?.lua;" .. package.path

local git = require("hydras.git")
local lsp = require("hydras.lsp")
local project = require("hydras.project")
local tab = require("hydras.tab")
local util = require("hydras.util")
local window = require("hydras.window")

util.base_hydra(
  "Main",
  [[
_y_: yank current path

_w_: windows  _p_: project
_t_: tabs     _l_: lsp
_g_: git

_<Esc>_
]],
  "<Leader>h",
  {
    {
      "y",
      function()
        vim.fn.setreg("*", vim.api.nvim_buf_get_name(0))
      end,
    },
    { "w", window.hydra },
    { "g", git.hydra },
    { "t", tab.hydra },

    { "p", project.hydra },
    { "l", lsp.hydra },
  }
)
