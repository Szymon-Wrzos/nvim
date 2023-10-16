local M = {}

M.init = function()
	require("dapui").setup()
	local dap, dapui = require("dap"), require("dapui")

	local langs = require("utils.langs_table")

	for k, v in pairs(langs) do
		if v.dap == nil then
			goto continue
		end
		::continue::
	end

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end

	vim.keymap.set({ "n" }, "<leader>be", dap.terminate, { desc = "De[b]ug t[e]rminate" })
end

local lazypath = vim.fn.stdpath("data") .. "/lazy"
M.config = {
	"rcarriga/nvim-dap-ui",
	keys = {
		{
			"<leader>bc",
			"<cmd>DapContinue<CR>",
			desc = "De[b]ug [c]ontinue",
			mode = "n",
		},

		{
			"<leader>bd",
			"<cmd>DapToggleBreakpoint<CR>",
			desc = "Toggle [d]ebug breakpoint",
			mode = "n",
		},
	},
	dependencies = {
		{
			"mfussenegger/nvim-dap",
			dependencies = {
				{
					"jay-babu/mason-nvim-dap.nvim",
					event = "VeryLazy",
					config = function()
						local langs = require("utils.langs_table")
						local vals_with_dap = {}
						for _, v in pairs(langs) do
							if v.dap ~= nil then
								table.insert(vals_with_dap, v.dap.mason)
							end
						end
						require("mason-nvim-dap").setup({
							ensure_installed = vim.tbl_flatten(vals_with_dap),
							automatic_installation = true,
							handlers = {},
						})
					end,
				},
				{
					"mxsdev/nvim-dap-vscode-js",
					config = function()
						require("dap-vscode-js").setup({
							-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
							debugger_path = lazypath .. "/vscode-js-debug", -- Path to vscode-js-debug installation.
							-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
							adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
						})
						local js_based_languages = { "typescript", "javascript", "typescriptreact" }
						require("dap.ext.vscode").load_launchjs(nil, {
							["pwa-node"] = js_based_languages,
							["node"] = js_based_languages,
							["chrome"] = js_based_languages,
							["pwa-chrome"] = js_based_languages,
						})
						for _, language in ipairs({ "typescript", "javascript" }) do
							require("dap").configurations[language] = {
								{
									type = "pwa-node",
									request = "launch",
									name = "Launch file",
									program = "${file}",
									cwd = "${workspaceFolder}",
								},
								{
									type = "pwa-node",
									request = "attach",
									name = "Attach",
									processId = require("dap.utils").pick_process,
									cwd = "${workspaceFolder}",
								},
								{
									type = "pwa-chrome",
									cwd = vim.fn.getcwd(),
									sourceMaps = true,
									protocol = "inspector",
									program = "${file}",
									request = "launch",
									name = 'Start Chrome with "localhost"',
									url = "http://localhost:3025",
									webRoot = "${workspaceFolder}/src",
									skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
								},
							}
						end
					end,
					dependencies = {
						"microsoft/vscode-js-debug",
						build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
						tag = "v1.74.1",
					},
				},
			},
			config = function()
				M.init()
			end,
		},
	},
}

return M
