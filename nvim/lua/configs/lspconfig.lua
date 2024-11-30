-- Load NvChad defaults
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"
local metals = require "metals"

-- Default LSP servers
local servers = { "html", "cssls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

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
  pattern = { "scala", "sbt", "java" },
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

-- TODO : remove later
vim.g.dap_set_log_level = "DEBUG"
