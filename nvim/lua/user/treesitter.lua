local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  vim.notify("nvim-treesitter.configs not found")
  return
end

configs.setup({
  ensure_installed = {
    "bash", "bibtex", "c", "cmake", "comment", "cpp", "css", "cuda", "diff",
    "dockerfile", "git_rebase", "gitattributes", "gitcommit", "gitignore",
    "go", "gomod", "gowork", "graphql", "html", "http",
    "javascript", "json", "json5", "julia", "latex", "llvm", "lua", "make",
    "markdown", "proto", "python", "regex", "rust", "solidity", "sql",
    "toml", "tsx", "typescript", "vim", "vue", "yaml"
  },
  highlight = { enable = true, disable = { "css" } },
  autopairs = { enable = true },
  indent = { enable = true, disable = { "python", "css" } }
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
