local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  vim.notify("mason not found")
  return
end

local mason_config_status_ok, mason_lspconfig =
    pcall(require, "mason-lspconfig")
if not mason_config_status_ok then
  vim.notify("mason-lspconfig not found")
  return
end

local servers = {
  "lua_ls", "rust_analyzer", "eslint", "tsserver", "pyright", "bashls",
  "jsonls", "yamlls", "gopls", "solidity_ls_nomicfoundation", "marksman", "clangd", "texlab"
}

local settings = {
  ui = { border = "rounded" },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4
}

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true
}

table.insert(servers, "move_analyzer")

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  vim.notify("lspconfig not found")
  return
end

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities
  }

  server = vim.split(server, "@")[1]

  if server == "lua_ls" then
    local require_ok, conf_opts = pcall(require, "user.lsp.settings.lua_ls")
    if require_ok then
      opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end
  end

  if server == "rust_analyzer" then
    local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
    if not rust_tools_status_ok then
      vim.notify("rust-tools not found")
      return
    end
    local rust_tools_config_status_ok, rust_tools_conf = pcall(require,
      "user.lsp.settings.rust_analyzer")
    if not rust_tools_config_status_ok then
      vim.notify("user.lsp.settings.rust_analyzer not found")
      return
    end

    rust_tools.setup(rust_tools_conf)
    goto continue
  end

  if server == "gopls" then
    local gopls_status_ok, gopls = pcall(require, "user.lsp.settings.gopls")
    if not gopls_status_ok then
      vim.notify("user.lsp.settings.gopls not found")
      return
    end
    opts.on_attach = gopls.on_attach
    opts.settings = gopls.settings
  end

  if server == "tsserver" then
    local tsserver_ok, tsserver_opts = pcall(require,
      "user.lsp.settings.tsserver")
    if tsserver_ok then
      opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
    end
  end

  if server == "clangd" then
    local clangd_ok, clangd_opts =
        pcall(require, "user.lsp.settings.clangd")

    if clangd_ok then
      opts = vim.tbl_deep_extend("force", clangd_opts, opts)
    end
  end

  lspconfig[server].setup(opts)
  ::continue::
end
