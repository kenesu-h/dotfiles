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

-- lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.tsserver.setup({
  init_options = {
    preferences = {
      importModuleSpecifier = "non-relative",
    },
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

local colors = require("catppuccin.palettes").get_palette("frappe")
local CmpColors = {
  Pmenu = { bg = colors.mantle },
  PmenuSel = { fg = colors.flamingo, bg = colors.base, bold = true },

  NormalFloat = { bg = colors.mantle },
  FloatBorder = { bg = colors.mantle },
}

for hl, col in pairs(CmpColors) do
  vim.api.nvim_set_hl(0, hl, col)
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
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
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
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp", keyword_length = 3, max_item_count = 10 },
    { name = "luasnip", keyword_length = 3, max_item_count = 10 },
    { name = "copilot" },
  }),
})
