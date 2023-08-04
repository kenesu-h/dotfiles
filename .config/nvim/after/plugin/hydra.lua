local Hydra = require("hydra")

local hint = [[
_f_: files          _g_: git
_s_: grep (search)  _u_: undotree
_b_: browser

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
    { "b", require("telescope").extensions.file_browser.file_browser },
    {
      "g",
      function()
        require("neogit").open({ kind = "auto" })
      end,
    },
    { "u", vim.cmd.UndotreeToggle },

    { "h", require("harpoon.ui").toggle_quick_menu },
    { "m", require("harpoon.mark").add_file },

    { "<Esc>", nil, { exit = true, nowait = true } },
  },
})
