local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  vim.notify("null-ls not found")
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  debug = true,
  sources = {
    diagnostics.checkmake, diagnostics.golangci_lint,
    diagnostics.write_good, diagnostics.zsh, formatting.autopep8,
    formatting.fixjson, formatting.goimports_reviser, formatting.golines,
    formatting.isort, formatting.lua_format, formatting.markdown_toc,
    formatting.mdformat, formatting.yamlfmt,
    formatting.rustfmt.with({ extra_args = { "--edition=2021" } }),
    diagnostics.cpplint, formatting.clang_format,
    formatting.forge_fmt,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end
      })
    end
  end
})
