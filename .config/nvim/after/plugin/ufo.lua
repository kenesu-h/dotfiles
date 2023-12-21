local ufo = require("ufo")

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set({ "n", "v", "o" }, "zR", ufo.openAllFolds)
vim.keymap.set({ "n", "v", "o" }, "zM", ufo.closeAllFolds)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingrange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local language_servers = require("lspconfig").util.available_servers()
for _, ls in ipairs(language_servers) do
  require("lspconfig")[ls].setup({
    capabilities = capabilities,
  })
end

ufo.setup()
