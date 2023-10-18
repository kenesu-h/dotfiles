local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "dockerls",
    "gopls",
    "lua_ls",
    "pyright",
    "rust_analyzer",
    "tsserver",
    "volar",
  },
})

local cmp = require("cmp")
local luasnip = require("luasnip")

-- https://www.reddit.com/r/neovim/comments/wmkf9o/how_to_use_tab_and_shifttab_to_cycle_through/
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({
      select = false,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
  }),
})
