local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  vim.notify("lazy not found")
end

local plugins = {
  "nvim-lua/plenary.nvim",

  -- color scheme
  "folke/tokyonight.nvim",

  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    tag = "0.1.0"
  },

  "nvim-tree/nvim-web-devicons",
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    tag = "nightly"
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", lazy = true }
  },
  { "akinsho/bufferline.nvim",         dependencies = "nvim-tree/nvim-web-devicons" },

  "windwp/nvim-autopairs",
  "numToStr/Comment.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "lewis6991/impatient.nvim",
  "simrat39/symbols-outline.nvim",
  "kosayoda/nvim-lightbulb",

  "folke/which-key.nvim",

  -- lsp
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  { "folke/trouble.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
  "lvimuser/lsp-inlayhints.nvim",

  "RRethy/vim-illuminate",

  -- completion
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",

  -- snippets
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",

  -- git
  "lewis6991/gitsigns.nvim",

  -- rust
  "simrat39/rust-tools.nvim",

  -- neorg
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.completion"] = {
          config = { engine = "nvim-cmp" }
        },
        ["core.export"] = {},
        ["core.export.markdown"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/Desktop/notes",
            },
          },
        },
        ["core.journal"] = {},
        ["core.esupports.metagen"] = {
          config = { type = "auto", }
        },
        ["core.esupports.indent"] = {
          config = { format_on_enter = false, format_on_escape = false }
        }
      },
    },
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
}
local opts = {}

lazy.setup(plugins, opts)
