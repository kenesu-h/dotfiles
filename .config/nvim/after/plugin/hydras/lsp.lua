--- @module "hydras.lsp"
local lsp = {}

local util = require("hydras.util")

local builtin = require("telescope.builtin")

--- @type fun():nil
lsp.hydra = util.activator(util.base_hydra(
  "LSP",
  [[
_c_: context
_s_: symbols
_e_: errors
_E_: focus error

_d_: definition
_D_: focus definition
_r_: references
_b_: back

_n_: name
_R_: restart

_<Esc>_
]],
  nil,
  {
    {
      "c",
      function()
        vim.cmd("TSContextToggle")
      end,
    },
    { "s", builtin.lsp_document_symbols },
    {
      "e",
      function()
        builtin.diagnostics({ bufnr = 0 })
      end,
    },
    {
      "E",
      function()
        vim.diagnostic.open_float()
        vim.diagnostic.open_float() -- Focus the diagnostic window
      end,
    },

    { "d", builtin.lsp_definitions },
    {
      "D",
      function()
        vim.lsp.buf.hover()
        vim.lsp.buf.hover() -- Focus the hover window
      end,
    },
    { "r", builtin.lsp_references },
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

    { "n", vim.lsp.buf.rename },
    {
      "R",
      function()
        vim.cmd(":LspRestart")
      end,
    },
  }
))

return lsp
