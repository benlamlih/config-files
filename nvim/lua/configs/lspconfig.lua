-- Load NvChad defaults
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"
local metals = require "metals"
local null_ls = require "null-ls"

vim.g.dbs = {
  {
    name = "linkifyqr_local",
    url = "postgres://docker:docker@localhost:5432/linkifyqr",
  },
}

-- Default LSP servers
local servers = { "html", "cssls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    root_dir = lspconfig.util.root_pattern("package.json", ".git"),
  }
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    require("configs.jdtls").setup()
  end,
})

lspconfig.pyright.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    pyright = {
      autoImportCompletion = true,
    },
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "off",
      },
    },
  },
}

-- Vue LSP (Volar)
lspconfig.volar.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false -- Disable Volar formatting
    nvlsp.on_attach(client, bufnr)
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    vue = {
      hybridMode = false,
    },
  },
  settings = {
    typescript = {
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        parameterTypes = { enabled = true, suppressWhenArgumentMatchesName = true },
        variableTypes = { enabled = true },
      },
    },
  },
}

-- TypeScript Language Server (ts_ls)
local mason_packages = vim.fn.stdpath "data" .. "/mason/packages"
local volar_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = volar_path,
        languages = { "vue" },
      },
    },
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}

-- Null-LS Configuration for Formatters and Linters
local b = null_ls.builtins
local sources = {
  b.formatting.prettier.with {
    command = "node_modules/.bin/prettier",
    filetypes = { "html", "markdown", "css", "typescript", "vue", "json" },
  },
  null_ls.builtins.formatting.black,
}

-- Setup Null-LS with Formatting on Save
null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}

-- Metals LSP Configuration
local metals_config = metals.bare_config()

metals_config.on_attach = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)
  metals.setup_dap() -- Attach Metals DAP
end
metals_config.on_init = nvlsp.on_init
metals_config.capabilities = nvlsp.capabilities

metals_config.settings = {
  showImplicitArguments = true,
  superMethodLensesEnabled = true,
  showInferredType = true,
}

metals_config.init_options = {
  statusBarProvider = "on",
}

-- Automatically start Metals for Scala files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt" },
  callback = function()
    metals.initialize_or_attach(metals_config)
  end,
})

-- nvim-dap Configuration
local dap = require "dap"
local dapui = require "dapui"

dapui.setup()

-- Automatically open/close DAP UI during debugging
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "Debug Scala Server",
    metals = {
      runType = "run",
      args = {}, -- Your application arguments
      jvmOptions = {}, -- Any JVM options you need
      env = {}, -- Environment variables
    },
  },
}

-- dap.adapters.java = {
--   type = "server",
--   host = "127.0.0.1",
--   port = 5006,
-- }

-- dap.configurations.scala = {
--   {
--     type = "java",
--     request = "attach",
--     name = "Debug Scala Server",
--     hostName = "127.0.0.1",
--     port = 5006,
--   },
-- }
