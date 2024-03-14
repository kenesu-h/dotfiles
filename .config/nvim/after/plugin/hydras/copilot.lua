--- @modules "hydras.copilot"
local copilot = {}

local util = require("hydras.util")

local chat = require("CopilotChat")

--- @type fun():nil
copilot.hydra = util.activator(util.base_hydra(
  "Copilot",
  [[
_c_: chat
_e_: explain
_t_: tests
_f_: fix
_d_: fix diagnostics
_o_: optimize
_r_: reset

_<Esc>_
]],
  nil,
  {
    { "c", chat.toggle },
    { "r", chat.reset },

    {
      "e",
      function()
        vim.cmd("CopilotChatExplain")
      end,
    },
    {
      "t",
      function()
        vim.cmd("CopilotChatTests")
      end,
    },
    {
      "f",
      function()
        vim.cmd("CopilotChatFix")
      end,
    },
    {
      "d",
      function()
        vim.cmd("CopilotChatFixDiagnostic")
      end,
    },
    {
      "o",
      function()
        vim.cmd("CopilotChatOptimize")
      end,
    },
  }
))

return copilot
