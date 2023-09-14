local M = {}

M.init = function()
	require("dapui").setup()

	require("mason-nvim-dap").setup({
		ensure_installed = { "python" },
		automatic_installation = true,
	})
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
	vim.keymap.set({ "n" }, "<leader>bg", dap.terminate, { desc = "De[b]ug terminate" })
end

M.config = {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = {
		{ "mfussenegger/nvim-dap", dependencies = {
			"rcarriga/nvim-dap-ui",
		} },
	},
	keys = {
		{
			"<leader>bc",
			'<cmd>lua require("dap").continue',
			desc = "De[b]ug [c]ontinue",
			mode = "n",
		},
	},
	config = function()
		M.init()
	end,
}
return M
