require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

vim.keymap.set({ "n" }, "<leader>bf", dap.toggle_breakpoint, { desc = "Toggle debug [b]reakpoint" })
vim.keymap.set({ "n" }, "<leader>bc", dap.continue, { desc = "De[b]ug [c]ontinue" })
vim.keymap.set({ "n" }, "<leader>bg", dap.terminate, { desc = "De[b]ug terminate" })
