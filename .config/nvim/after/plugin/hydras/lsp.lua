--- @module "hydras.lsp"
local lsp = {}

local util = require("hydras.util")

local builtin = require("telescope.builtin")

--- @type fun():nil
lsp.hydra = util.activator(util.base_hydra(
  "LSP",
  [[
_e_: errors
_f_: focus

_d_: definition   _n_: name
_r_: references   _b_: back
_c_: context

_<Esc>_
]],
  nil,
  {
    -- Errors
    {
      "e",
      function()
        builtin.diagnostics({ bufnr = 0 })
      end,
    },
    {
      "f",
      function()
        vim.diagnostic.open_float()
        -- Calling open_float again focuses the diagnostic window
        vim.diagnostic.open_float()
      end,
    },

    -- Other
    {
      "c",
      function()
        vim.cmd("TSContextToggle")
      end,
    },
    { "d", builtin.lsp_definitions },
    { "r", builtin.lsp_references },

    { "n", vim.lsp.buf.rename },
    {
      "b",
      function()
        if vim.fn.gettagstack().curidx > 1 then
          vim.cmd("pop")
        else
          print("Tag stack is empty!")
        end
      end,
      { exit = false },
    },
  }
))

return lsp
