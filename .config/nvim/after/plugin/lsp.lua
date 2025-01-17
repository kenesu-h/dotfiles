local cmp = require("cmp")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")
local luasnip = require("luasnip")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local rose_pine = require("rose-pine.palette")
local snippets_from_vscode = require("luasnip.loaders.from_vscode")

-- Setup appearance
local CmpColors = {
  Pmenu = { bg = rose_pine.surface },
  PmenuSel = { fg = rose_pine.rose, bg = rose_pine.overlay },

  NormalFloat = { bg = rose_pine.surface },
  FloatBorder = { bg = rose_pine.surface },
}

vim.diagnostic.config({
  virtual_text = false,
  float = {
    border = "single",
  },
})

for hl, col in pairs(CmpColors) do
  vim.api.nvim_set_hl(0, hl, col)
end

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Setup LSP and snippets
mason.setup({})
mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
    "basedpyright",
    "ts_ls",
  },
  handlers = {
    function(server)
      lspconfig[server].setup({
        capabilities = cmp_nvim_lsp.default_capabilities(),
      })
    end,
  },
})

snippets_from_vscode.lazy_load()

-- Setup auto-completion
local has_words_before = function()
  if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
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
  -- sorting = {
  --   comparators = {
  --     cmp.config.compare.exact,
  --     cmp.config.compare.offset,
  --     cmp.config.compare.score,
  --     cmp.config.compare.recently_used,
  --     cmp.config.compare.locality,
  --     cmp.config.compare.kind,
  --     cmp.config.compare.sort_text,
  --     cmp.config.compare.length,
  --     cmp.config.compare.order,
  --   },
  -- },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "lazydev" },
  }),
})
