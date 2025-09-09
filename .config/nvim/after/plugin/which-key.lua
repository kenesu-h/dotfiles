local gitsigns = require("gitsigns")
local grug_far = require("grug-far")
local oil = require("oil")
local rose_pine = require("rose-pine.palette")
local snacks = require("snacks")
local wk = require("which-key")

local WhichKeyColors = {
  WhichKeyTitle = { bg = rose_pine.rose, fg = rose_pine.surface },
  WhichKeyNormal = { bg = rose_pine.overlay },
  WhichKeyBorder = { bg = rose_pine.overlay },
}

for hl, col in pairs(WhichKeyColors) do
  vim.api.nvim_set_hl(0, hl, col)
end

--- @param forward boolean
--- @return nil
local function move_tab(forward)
  local error = not pcall(function()
    if forward then
      vim.cmd("+tabmove")
    else
      vim.cmd("-tabmove")
    end
  end)

  if error then
    print("Cannot move tab!")
  end
end

wk.add({
  { "<leader>s", group = "split" },
  {
    "<leader>sh",
    function()
      vim.cmd("vsplit")
    end,
    desc = "Split Left",
  },
  {
    "<leader>sj",
    function()
      vim.cmd("split")
      vim.cmd("wincmd j")
    end,
    desc = "Split Down",
  },
  {
    "<leader>sk",
    function()
      vim.cmd("split")
    end,
    desc = "Split Up",
  },
  {
    "<leader>sl",
    function()
      vim.cmd("vsplit")
      vim.cmd("wincmd l")
    end,
    desc = "Split Left",
  },

  {
    "<leader>t",
    group = "tab",
  },
  {
    "<leader>tc",
    function()
      vim.cmd("tab split")
    end,
    desc = "Create Tab",
  },
  {
    "<leader>th",
    function()
      move_tab(false)
    end,
    desc = "Move Tab Left",
  },
  {
    "<leader>tl",
    function()
      move_tab(true)
    end,
    desc = "Move Tab Right",
  },
  {
    "<leader>tx",
    function()
      if not pcall(function()
        vim.cmd("tabclose")
      end) then
        print("Cannot close last tab!")
      end
    end,
    desc = "Close Tab",
  },

  { "<leader>f", group = "file" },
  {
    "<leader>ff",
    snacks.picker.files,
    desc = "Find Files",
  },
  {
    "<leader>fb",
    snacks.picker.buffers,
    desc = "Find Buffers",
  },
  {
    "<leader>fg",
    snacks.picker.grep,
    desc = "Grep Files",
  },
  {
    "<leader>fo",
    oil.open,
    desc = "Open Parent Directory",
  },

  { "<leader>g", group = "git" },
  {
    "<leader>gs",
    function()
      if not pcall(snacks.picker.git_status) then
        print("Working directory is not a Git directory!")
      end
    end,
    desc = "Show Status",
  },
  {
    "<leader>gb",
    gitsigns.toggle_current_line_blame,
    desc = "Toggle Blame",
  },

  { "<leader>gh", group = "hunk" },
  {
    "<leader>ghh",
    gitsigns.preview_hunk,
    desc = "Show Hunk",
  },
  {
    "<leader>ghr",
    gitsigns.reset_hunk,
    desc = "Reset Hunk",
  },

  { "<leader>l", group = "lsp" },
  {
    "<leader>le",
    snacks.picker.diagnostics_buffer,
    desc = "Show Errors",
  },
  {
    "<leader>ld",
    snacks.picker.lsp_definitions,
    desc = "Jump to Definition",
  },
  {
    "<leader>ls",
    function()
      vim.lsp.buf.hover()
      vim.lsp.buf.hover()
    end,
    desc = "Show Signature",
  },
  {
    "<leader>lr",
    snacks.picker.lsp_references,
    desc = "Jump to References",
  },

  { "<leader>r", group = "refactor" },
  {
    "<leader>rs",
    vim.lsp.buf.rename,
    desc = "Rename Symbol",
  },
  {
    "<leader>rf",
    snacks.rename.rename_file,
    desc = "Rename File",
  },
  {
    "<leader>rr",
    function()
      grug_far.open({ windowCreationCommand = vim.o.columns > 160 and "vsplit" or "belowright split" })
    end,
    desc = "Find and Replace All",
  },

  {
    "<leader>b",
    function()
      if vim.fn.gettagstack().curidx > 1 then
        vim.cmd("pop")
      else
        print("Tag stack is empty!")
      end
    end,
    desc = "Jump Back",
  },
})

wk.setup({
  preset = "helix",
  delay = 0,
  win = {
    padding = { 1, 2 },
  },
  icons = {
    rules = {
      {
        pattern = "back",
        icon = " ",
        color = "red",
      },
      {
        pattern = "toggle",
        icon = " ",
        color = "red",
      },
      {
        pattern = "file",
        icon = "󰈔 ",
        color = "red",
      },
      {
        pattern = "git",
        icon = " ",
        color = "orange",
      },
      {
        pattern = "lsp",
        icon = " ",
        color = "yellow",
      },
      {
        pattern = "refactor",
        icon = " ",
        color = "green",
      },
      {
        pattern = "split",
        icon = " ",
        color = "blue",
      },
      {
        pattern = "tab",
        icon = "󰓩 ",
        color = "purple",
      },
    },
  },
})
