local M = {}
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.offsetEncoding = "utf-8"
M.capabilities = capabilities

return M
