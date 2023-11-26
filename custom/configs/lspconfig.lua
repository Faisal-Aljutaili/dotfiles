local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
require("lspconfig").intelephense.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"php"}
}
require("lspconfig").dockerls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"dockerfile"}
}
require("lspconfig").docker_compose_language_service.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"yaml","docker-compose"}
}
require("lspconfig").eslint.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro"}
}
require("lspconfig").cssls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"css", "scss", "less"}
}
require("lspconfig").stimulus_ls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"html", "ruby", "eruby", "blade", "php"}
}
require("lspconfig").tsserver.setup{
}
require'lspconfig'.anakin_language_server.setup{}
require'lspconfig'.jedi_language_server.setup{}
require'lspconfig'.sqlls.setup{}

-- Without the loop, you would have to manually set up each LSP 
-- 
-- lspconfig.html.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- lspconfig.cssls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
