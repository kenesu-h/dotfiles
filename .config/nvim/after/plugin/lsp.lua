-- https://github.com/neovim/neovim/issues/23725#issuecomment-1561364086
local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
  -- disable lsp watcher. Too slow on linux
  wf._watchfunc = function()
    return function() end
  end
end

require("neodev").setup({})

local lsp = require("lsp-zero").preset({})
local lspconfig = require("lspconfig")

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

local node_lib = function()
  local handle = io.popen("npm list -g | head -1")
  if not handle then
    return nil
  end

  local result = handle:read("*a")
  handle:close()

  return result:gsub("[\n\r]", "")
end

lspconfig.tsserver.setup({
  init_options = {
    preferences = {
      importModuleSpecifier = "non-relative",
    },
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = node_lib() .. "/node_modules/@vue/typescript-plugin",
        languages = { "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "vue",
  },
})

lsp.setup()

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "pyright",
    "tsserver",
  },
})

local cmp = require("cmp")
local luasnip = require("luasnip")

vim.diagnostic.config({
  float = {
    border = "single",
  },
})

local rose_pine = require("rose-pine.palette")
local CmpColors = {
  Pmenu = { bg = rose_pine.surface },
  PmenuSel = { fg = rose_pine.rose, bg = rose_pine.overlay },

  NormalFloat = { bg = rose_pine.surface },
  FloatBorder = { bg = rose_pine.surface },
}

for hl, col in pairs(CmpColors) do
  vim.api.nvim_set_hl(0, hl, col)
end

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

-- https://www.reddit.com/r/neovim/comments/wmkf9o/how_to_use_tab_and_shifttab_to_cycle_through/
-- https://www.reddit.com/r/neovim/comments/z9os8x/strange_behaviour_cursor_jumping_with_tabkey/
cmp.setup({
  window = {
    documentation = {
      border = "single",
    },
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({
      select = false,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
  }),
  sorting = {
    comparators = {
      cmp.config.compare.exact,
      cmp.config.compare.offset,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
  }),
})
