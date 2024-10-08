package.path = vim.fn.stdpath("config") .. "/after/plugin/?.lua;" .. package.path

local git = require("hydras.git")
local lsp = require("hydras.lsp")
local project = require("hydras.project")
local tab = require("hydras.tab")
local util = require("hydras.util")
local window = require("hydras.window")

local chat = require("CopilotChat")
local rose_pine = require("rose-pine.palette")
local HydraColors = {
  HydraHint = { bg = rose_pine.surface },
  HydraBorder = { bg = rose_pine.surface },
}

for hl, col in pairs(HydraColors) do
  vim.api.nvim_set_hl(0, hl, col)
end

util.base_hydra(
  "Main",
  [[
_w_: windows  _p_: project
_t_: tabs     _l_: lsp

_g_: git
_c_: copilot chat

_<Esc>_
]],
  "<Leader>",
  {

    { "w", window.hydra },
    { "t", tab.hydra },

    { "p", project.hydra },
    { "l", lsp.hydra },

    { "g", git.hydra },
    {
      "c",
      function()
        vim.cmd('let @"=" "')
        chat.toggle()
      end,
    },
  }
)
