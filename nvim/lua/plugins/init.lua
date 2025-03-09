return {
  -- Diff view
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" }, -- Lazy-load on these commands
    config = function()
      require("diffview").setup()
    end,
  },

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

  -- Typing Practice plugin
  { "nvzone/volt", lazy = true },
  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
  },
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },

  -- Maybe try blink.cmp later instead of cmp
  -- {
  --   "hrsh7th/nvim-cmp",
  --   enabled = false,
  -- },

  -- Scala cmp
  -- {
  --   "saghen/blink.cmp",
  --   ft = { "scala" },
  --   lazy = false, -- lazy loading handled internally
  --   dependencies = "rafamadriz/friendly-snippets",
  --   version = "v0.*",
  --   ---@module 'blink.cmp'
  --   ---@type blink.cmp.Config
  --   opts = {
  --     -- keymap = {
  --     --   preset = "enter",
  --     --   ["<Tab>"] = { "select_next", "fallback" },
  --     --   ["<S-Tab"] = { "select_prev", "fallback" },
  --     -- },
  --     appearance = {
  --       -- Sets the fallback highlight groups to nvim-cmp's highlight groups
  --       -- Useful for when your theme doesn't support blink.cmp
  --       -- will be removed in a future release
  --       use_nvim_cmp_as_default = true,
  --       nerd_font_variant = "mono",
  --     },
  --     sources = {
  --       default = { "lsp", "path", "snippets", "buffer" },
  --     },
  --     signature = { enabled = true },
  --   },
  --   opts_extend = { "sources.default" },
  -- },

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
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
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
  {
    "windwp/nvim-ts-autotag",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
}
