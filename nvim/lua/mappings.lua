require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Tmux navigation mappings
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Window left" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Window right" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Window down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Window up" })

-- Compare buffer to clipboard
map("n", "<leader>cb", "<cmd>lua compare_to_clipboard()<CR>", { desc = "Compare buffer to clipboard" })

-- Debug Adapter Protocol (DAP) keymaps
map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Start/Continue Debugging" })

map("n", "<leader>ds", function()
  require("dap").step_over()
end, { desc = "Step Over" })

map("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "Step Into" })

map("n", "<leader>do", function()
  require("dap").step_out()
end, { desc = "Step Out" })

map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })

map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Toggle DAP UI" })

map("n", "<leader>dr", function()
  require("dap").repl.toggle()
end, { desc = "Toggle REPL" })

map("n", "<leader>dx", function()
  require("dap").terminate()
end, { desc = "Terminate Debug Session" })

-- Metals keymaps
map("n", "<leader>fi", ":MetalsOrganizeImports<CR>", { desc = "Organize Imports" })
map("n", "<leader>ml", ":MetalsToggleLogs<CR>", { desc = "Show Metals Logs" })
map("n", "<leader>mc", ":Telescope metals commands<CR>", { desc = "Metals Commands" })
map("n", "<leader>gr", ":Telescope lsp_references<CR>", { desc = "Find References" })

-- Resize current window width
map("n", "<C-b>", "<C-w>>", { desc = "Increase window width" }) -- Make buffer wider
map("n", "<C-g>", "<C-w><", { desc = "Decrease window width" }) -- Make buffer narrower

-- Database ui keymaps
map("n", "<leader>dt", ":DBUI<CR>", { desc = "Open drawer with available connections" })
map("n", "<C-t>", ":DBUIToggle<CR>", { desc = "Toggle the drawer" })

-- LSP Diagnostic keymaps
map("n", "<leader>lf", function()
  vim.diagnostic.open_float { border = "rounded" }
end, { desc = "Floating Diagnostic" })
