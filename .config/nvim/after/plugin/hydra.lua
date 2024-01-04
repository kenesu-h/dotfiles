local Hydra = require("hydra")

local builtin = require("telescope.builtin")
local gitsigns = require("gitsigns")
local harpoon = require("harpoon")

---@diagnostic disable-next-line: missing-parameter
harpoon:setup()

local table_unpack = table.unpack or unpack

---@param name string
---@param hint string
---@param body string?
---@param heads table<string, any>
---@return Hydra
local function base_hydra(name, hint, body, heads)
  return Hydra({
    name = name,
    hint = hint,
    mode = { "n", "v", "o" },
    body = body,
    config = {
      color = "teal",
      invoke_on_body = true,
      hint = {
        position = "middle",
        border = "rounded",
      },
    },
    heads = {
      { "<Esc>", nil, { exit = true, nowait = true } },
      table_unpack(heads),
    },
  })
end

---@param hydra Hydra
---@return fun():nil
local function get_activator(hydra)
  return function()
    hydra:activate()
  end
end

local windows_hydra = base_hydra(
  "Windows",
  [[
split:
_h_: left, _j_: down, _k_: up, _l_: right

_s_: swap

_<Esc>_
]],
  nil,
  {
    {
      "h",
      function()
        vim.cmd("vsplit")
      end,
    },
    {
      "j",
      function()
        vim.cmd("split")
        vim.cmd("wincmd j")
      end,
    },
    {
      "k",
      function()
        vim.cmd("split")
      end,
    },
    {
      "l",
      function()
        vim.cmd("vsplit")
        vim.cmd("wincmd l")
      end,
    },
    {
      "s",
      function()
        vim.cmd("WinShift swap")
      end,
    },
  }
)

local tabs_hydra = base_hydra(
  "Tabs",
  [[
_h_: move left  _l_: move right
_c_: create
_x_: close

_<Esc>_
]],
  nil,
  {
    {
      "h",
      function()
        vim.cmd("-tabmove")
      end,
      { exit = false },
    },
    {
      "c",
      function()
        vim.cmd("tab split")
      end,
    },
    {
      "x",
      function()
        vim.cmd("tabclose")
      end,
    },

    {
      "l",
      function()
        vim.cmd("+tabmove")
      end,
      { exit = false },
    },
  }
)

local hunk_hydra = base_hydra(
  "Hunk",
  [[
_r_: reset  _p_: preview

_<Esc>_
]],
  nil,
  {
    { "r", gitsigns.reset_hunk },

    { "p", gitsigns.preview_hunk_inline },
  }
)

local git_hydra = base_hydra(
  "Git",
  [[
_s_: status  _h_: hunk
^^           _b_: blame
^^           _o_: open url

_<Esc>_
]],
  nil,
  {
    { "s", builtin.git_status },

    { "h", get_activator(hunk_hydra) },
    {
      "b",
      function()
        vim.cmd("GitBlameToggle")
      end,
    },
    {
      "o",
      function()
        vim.cmd("GitBlameOpenFileURL")
      end,
    },
  }
)

local project_hydra = base_hydra(
  "Project",
  [[
_f_: files     _b_: browser
_g_: grep      _t_: todo
_h_: harpoon   _m_: mark

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
      "t",
      function()
        vim.cmd("TodoTelescope")
      end,
    },
    {
      "m",
      function()
        harpoon:list():append()
      end,
    },
  }
)

local lsp_hydra = base_hydra(
  "LSP",
  [[
_e_: errors      _n_: name
_d_: definition  _b_: back
_r_: references

_<Esc>_
]],
  nil,
  {
    {
      "e",
      function()
        builtin.diagnostics({ bufnr = 0 })
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
)

base_hydra(
  "Main",
  [[
_w_: windows  _p_: project
_t_: tabs     _l_: lsp
_g_: git

_<Esc>_
]],
  "<Leader>h",
  {
    { "w", get_activator(windows_hydra) },
    { "g", get_activator(git_hydra) },
    { "t", get_activator(tabs_hydra) },

    { "p", get_activator(project_hydra) },
    { "l", get_activator(lsp_hydra) },
  }
)
