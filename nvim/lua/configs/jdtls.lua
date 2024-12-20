local M = {}
local nvlsp = require "nvchad.configs.lspconfig"

function M.setup()
  local jdtls = require "jdtls"

  -- Define paths
  local home = vim.fn.expand "~"
  local jdtls_root = home .. "/.local/share/jdtls"
  local launcher_jar = jdtls_root .. "/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar" -- Update the version if necessary
  local config_dir = jdtls_root .. "/config_mac_arm" -- Use `config_mac_arm` for M1 Mac

  -- Workspace directory (per project)
  local workspace_dir = home .. "/.local/share/jdtls/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

  -- JDTLS Config
  local config = {
    cmd = {
      "/usr/bin/java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      launcher_jar,
      "-configuration",
      config_dir,
      "-data",
      workspace_dir,
    },
    root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew" },
    settings = {
      java = {
        configuration = {
          runtimes = {
            {
              name = "JavaSE-21",
              path = "/usr/bin/java",
            },
          },
        },
      },
    },
    init_options = {
      bundles = {}, -- @TODO: Add debug adapter later
    },
    filetypes = { "java" },
    on_attach = function(client, bufnr)
      nvlsp.on_attach(client, bufnr)
    end,
    capabilities = nvlsp.capabilities,
  }

  -- Start or attach JDTLS
  jdtls.start_or_attach(config)
end

return M
