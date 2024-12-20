return {
  -- Formatter
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  --Java
  {
    "mfussenegger/nvim-jdtls",
    config = function()
      require("configs.jdtls").setup()
    end,
  },

  -- Tmux navigation
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  -- Null-ls for formatting and linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
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
        "vue",
      },
    },
  },

  {
    "tpope/vim-dadbod",
    lazy = true,
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
      "DB",
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_win_position = "right"
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql", "plsql" },
    lazy = true,
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
