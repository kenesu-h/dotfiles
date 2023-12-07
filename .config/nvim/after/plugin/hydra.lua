local Hydra = require("hydra")

local hydra_config = {
  color = "teal",
  invoke_on_body = true,
  hint = {
    position = "middle",
    border = "rounded",
  },
}

local head_exit = { "<Esc>", nil, { exit = true, nowait = true } }

local main_hint = [[
_f_: files          _l_: lsp
_s_: grep (search)  _b_: browser
_g_: git            _u_: undotree

_h_: harpoon        _m_: mark

_<Esc>_
]]

local lsp_hint = [[
_e_: diagnostics (errors)
_s_: symbols
_d_: definition
_r_: references
_n_: rename (name)

_<Esc>_
]]

local git_hint = [[
_s_: status
_b_: blame
_o_: open url

_<Esc>_
]]

local builtin = require("telescope.builtin")

Hydra({
  name = "Main",
  hint = main_hint,
  config = hydra_config,
  mode = { "n", "v" },
  body = "<Leader>h",
  heads = {
    { "f", builtin.find_files },
    { "s", builtin.live_grep },
    {
      "g",
      function()
        Hydra({
          name = "Git",
          hint = git_hint,
          config = hydra_config,
          mode = { "n", "v" },
          heads = {
            { "s", builtin.git_status },
            { "b", require("gitblame").toggle },
            { "o", ":GitBlameOpenFileURL<CR>" },
            head_exit,
          },
        }):activate()
      end,
    },

    {
      "l",
      function()
        Hydra({
          name = "LSP",
          hint = lsp_hint,
          config = hydra_config,
          mode = { "n", "v" },
          heads = {
            {
              "e",
              function()
                builtin.diagnostics({ bufnr = 0 })
              end,
            },
            { "s", builtin.lsp_document_symbols },
            { "d", builtin.lsp_definitions },
            { "r", builtin.lsp_references },
            { "n", vim.lsp.buf.rename },
            head_exit,
          },
        }):activate()
      end,
    },
    { "b", require("telescope").extensions.file_browser.file_browser },
    { "u", vim.cmd.UndotreeToggle },

    { "h", require("harpoon.ui").toggle_quick_menu },
    { "m", require("harpoon.mark").add_file },

    head_exit,
  },
})
