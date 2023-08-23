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
	{
		"nvim-tree/nvim-tree.lua",
		keys = { {
			"<leader>rr",
			"<cmd>:NvimTreeToggle<cr>",
			desc = "Nvim T[r]ee Toggle",
		} },
		config = function()
			require("plugins.nvim_tree.init").init()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			vim.cmd([[:TSUpdate]])
		end,
		event = "VeryLazy",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-tree-docs",
		},
		config = function()
			require("plugins.treesitter.init")
		end,
	},
	{
		"williamboman/mason.nvim",
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
		config = function()
			require("mason").setup()
		end,
	},
	{ "jose-elias-alvarez/typescript.nvim" },
	"nvim-lua/plenary.nvim",
	"lukas-reineke/lsp-format.nvim",
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.telescope.init").init()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.gitsigns.init").init()
		end,
	},
	{
		"jcdickinson/codeium.nvim",
		event = "InsertEnter",

		config = function()
			require("codeium").setup()
		end,
	},
	{
		"kdheepak/lazygit.nvim",

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

		config = function()
			require("plugins.wilder.init").init()
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
		end,
	},

	{
		"ggandor/leap.nvim",
		event = "VeryLazy",
		dependencies = {
			"tpope/vim-repeat",
		},
		config = function()
			require("leap").add_default_mappings()
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertCharPre",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "onsails/lspkind.nvim" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "jcha0713/cmp-tw2css" },
			{
				"L3MON4D3/LuaSnip",
				config = function()
					-- Snippets
					require("snippets.javascript.init")
					require("snippets.css.init")

					vim.keymap.set(
						{ "n", "i" },
						"<C-Esc>",
						require("luasnip").unlink_current,
						{ desc = "Unlink current snippet" }
					)
				end,
			},
		},
		config = function()
			require("plugins.cmp.init").init()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.lualine.init").init()
		end,
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			require("plugins.bufferline.init").init()
		end,
	},

	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.trouble.init").init()
		end,
	},
	{
		"windwp/nvim-spectre",
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
		keys = { {
			"<leader>ca",
			"<cmd>:CodeActionMenu<cr>",
			desc = "[C]ode [A]ction",
		} },
	},

	{
		"terrortylor/nvim-comment",
		event = "VeryLazy",
		config = function()
			require("nvim_comment").setup({})
		end,
	},
	{
		"echasnovski/mini.cursorword",
		config = function()
			require("mini.cursorword").setup()
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300

			require("plugins.which_key.init").init()
		end,
	},
}, {
	defaults = {
		lazy = true,
	},
	checker = {
		enabled = true,
	},
})
