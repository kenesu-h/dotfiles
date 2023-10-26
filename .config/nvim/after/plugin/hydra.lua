local Hydra = require("hydra")

local hint = [[
_f_: files          _b_: browser
_s_: grep (search)  _u_: undotree
_d_: diagnostics
_r_: rename

_h_: harpoon        _m_: mark

                        _<Esc>_
]]

local builtin = require("telescope.builtin")

Hydra({
  name = "Telescope",
  hint = hint,
  config = {
    color = "teal",
    invoke_on_body = true,
    hint = {
      position = "middle",
      border = "rounded",
    },
  },
  mode = "n",
  body = "<Leader>h",
  heads = {
    { "f", builtin.find_files },
    { "s", builtin.live_grep },
    { "d", require("telescope.builtin").diagnostics },
    { "b", require("telescope").extensions.file_browser.file_browser },
    { "r", vim.lsp.buf.rename },
    { "u", vim.cmd.UndotreeToggle },

    { "h", require("harpoon.ui").toggle_quick_menu },
    { "m", require("harpoon.mark").add_file },

    { "<Esc>", nil, { exit = true, nowait = true } },
  },
})
