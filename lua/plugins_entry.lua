local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({

	{
		"rmehri01/onenord.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("onenord").setup({
				theme = "dark",
			})
		end,
	},
	"nvim-tree/nvim-tree.lua",
	{
		"nvim-treesitter/nvim-treesitter",

		lazy = true,
		event = "BufEnter",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-tree-docs",
		},
	},
	{
		"williamboman/mason.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"b0o/schemastore.nvim",
			{ "williamboman/mason-lspconfig.nvim", dependencies = {
				"neovim/nvim-lspconfig",
			} },
			{ "jay-babu/mason-null-ls.nvim", dependencies = {
				"jose-elias-alvarez/null-ls.nvim",
			} },
		},
	},
	{ "jose-elias-alvarez/typescript.nvim" },
	"nvim-lua/plenary.nvim",
	"lukas-reineke/lsp-format.nvim",
	{ "nvim-telescope/telescope.nvim", event = "VeryLazy" },
	{ "lewis6991/gitsigns.nvim", event = "VeryLazy" },
	{ "jcdickinson/codeium.nvim", event = "InsertEnter", lazy = true },
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		keys = { {
			"<leader>lg",
			"<cmd>:LazyGit<cr>",
			desc = "[L]azy[g]it",
		} },
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"wookayin/wilder.nvim",
		event = "CmdlineEnter",
		lazy = true,
		config = function()
			local wilder = require("wilder")

			local highlights = {
				accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "orange" } }),
			}

			wilder.setup({ modes = { ":", "/", "?", ":%s/" } })
			-- Disable Python remote plugin
			wilder.set_option("use_python_remote_plugin", 0)

			wilder.set_option("pipeline", {
				wilder.branch(
					wilder.cmdline_pipeline({
						fuzzy = 1,
						fuzzy_filter = wilder.lua_fzy_filter(),
					}),
					wilder.vim_search_pipeline()
				),
			})

			wilder.set_option(
				"renderer",
				wilder.renderer_mux({
					[":"] = wilder.popupmenu_renderer({
						highlighter = wilder.lua_fzy_highlighter(),
						highlights = highlights,
						left = {
							" ",
							wilder.popupmenu_devicons(),
						},
						right = {
							" ",
							wilder.popupmenu_scrollbar(),
						},
					}),
					["/"] = wilder.wildmenu_renderer({
						highlighter = wilder.lua_fzy_highlighter(),
						highlights = highlights,
					}),
					[":%s/"] = wilder.wildmenu_renderer({
						highlighter = wilder.lua_fzy_highlighter(),
						highlights = highlights,
					}),
				})
			)
		end,
	},
	"romgrk/fzy-lua-native",
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			{ "mfussenegger/nvim-dap", dependencies = {
				"rcarriga/nvim-dap-ui",
			} },
		},
		lazy = true,
		keys = {
			{
				"<leader>bc",
				'<cmd>lua require("dap").continue',
				desc = "De[b]ug [c]ontinue",
				mode = "n",
			},
		},
		config = function()
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

			dap.adapters.python = function(cb, config)
				vim.print(cb, config)
				if config.request == "attach" then
					---@diagnostic disable-next-line: undefined-field
					local port = (config.connect or config).port
					---@diagnostic disable-next-line: undefined-field
					local host = (config.connect or config).host or "127.0.0.1"
					cb({
						type = "server",
						port = assert(port, "`connect.port` is required for a python `attach` configuration"),
						host = host,
						options = {
							source_filetype = "python",
						},
					})
				else
					cb({
						type = "executable",
						command = "python",
						args = { "-m", "debugpy.adapter" },
						options = {
							source_filetype = "python",
						},
					})
				end
			end

			dap.configurations.python = {
				{
					type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
					request = "launch",
					name = "Launch file",
					program = "${file}", -- This configuration will launch the current file if used.
				},
			}
		end,
	},

	{ "ggandor/leap.nvim", dependencies = {
		"tpope/vim-repeat",
	} },

	{
		"hrsh7th/nvim-cmp",
		event = "InsertCharPre",
		lazy = true,
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "onsails/lspkind.nvim" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "jcha0713/cmp-tw2css" },
			{ "L3MON4D3/LuaSnip" },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	},
	{ "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons", lazy = true } },

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	},
	{
		"windwp/nvim-spectre",
		lazy = true,
		keys = {
			{
				"<leader>S",
				'<cmd>lua require("spectre").open()<CR>',
				desc = "Open [S]pectre",
			},
			{
				"<leader>sw",
				'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
				desc = "[s]earch current [w]ord",
			},
			{
				"<leader>sf",
				'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
				desc = "[s]earch in current [f]ile",
			},
		},
		config = function()
			require("spectre").setup({
				live_update = true,
			})
		end,
	},
	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	},
	"terrortylor/nvim-comment",
	"echasnovski/mini.cursorword",
	{
		"folke/which-key.nvim",
		lazy = true,
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
})
