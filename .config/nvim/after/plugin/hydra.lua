package.path = vim.fn.stdpath("config") .. "/after/plugin/?.lua;" .. package.path

local copilot = require("hydras.copilot")
local git = require("hydras.git")
local lsp = require("hydras.lsp")
local project = require("hydras.project")
local tab = require("hydras.tab")
local util = require("hydras.util")
local window = require("hydras.window")

local colors = require("catppuccin.palettes").get_palette("frappe")
local HydraColors = {
  HydraHint = { bg = colors.mantle },
  HydraBorder = { bg = colors.mantle },
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
_c_: copilot

_<Esc>_
]],
  "<Leader>h",
  {

    { "w", window.hydra },
    { "t", tab.hydra },

    { "p", project.hydra },
    { "l", lsp.hydra },

    { "g", git.hydra },
    { "c", copilot.hydra },
  }
)
