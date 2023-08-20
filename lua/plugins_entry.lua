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
	"nvim-tree/nvim-tree.lua",
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-tree-docs",
		},
	},
	{
		"williamboman/mason.nvim",
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
	"L3MON4D3/LuaSnip",
	"jose-elias-alvarez/typescript.nvim",
	"nvim-lua/plenary.nvim",
	"lukas-reineke/lsp-format.nvim",
	"nvim-telescope/telescope.nvim",
	"lewis6991/gitsigns.nvim",
	"rmehri01/onenord.nvim",
	"jcdickinson/codeium.nvim",
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

	"wookayin/wilder.nvim", -- This fork contains fix for completion command line -- Keep track on main repo
	"romgrk/fzy-lua-native",
	{ "jay-babu/mason-nvim-dap.nvim", dependencies = {
		"mfussenegger/nvim-dap",
	} },

	{ "ggandor/leap.nvim", dependencies = {
		"tpope/vim-repeat",
	} },

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "onsails/lspkind.nvim" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "jcha0713/cmp-tw2css" },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
	},
	{ "akinsho/bufferline.nvim", dependencies = "nvim-tree/nvim-web-devicons" },

	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
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
			}
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
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	"echasnovski/mini.cursorword",
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
})
