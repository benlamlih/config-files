return {
  -- Formatter
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  -- Tmux navigation
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Metals (Scala LSP)
  {
    "scalameta/nvim-metals",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required for Metals
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "java",
        "scala",
        "javascript",
        "typescript",
      },
    },
  },

  -- Debugging Plugins
  {
    "mfussenegger/nvim-dap",
  },
  { "nvim-neotest/nvim-nio" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
}
