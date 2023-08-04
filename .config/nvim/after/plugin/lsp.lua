local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(_, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({ buffer = bufnr })
end)

-- (Optional) Configure lua language server for neovim
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local cmp = require("cmp")
local luasnip = require("luasnip")

-- https://www.reddit.com/r/neovim/comments/wmkf9o/how_to_use_tab_and_shifttab_to_cycle_through/
local function cmp_select_next(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    fallback()
  end
end

local function cmp_select_prev(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    fallback()
  end
end

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(cmp_select_next, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(cmp_select_prev, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
})
