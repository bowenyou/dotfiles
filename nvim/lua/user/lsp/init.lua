local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("lspconfig not found")
  return
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  end
})

require "user.lsp.trouble"
require "user.lsp.symbols-outline"
require "user.lsp.nvim-lightbulb"
require "user.lsp.mason"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
