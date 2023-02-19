require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use("savq/melange-nvim")
	use("kevinhwang91/rnvimr")
	use("nvim-treesitter/nvim-treesitter")

	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")

	use("hrsh7th/cmp-nvim-lsp")
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
			{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" },
		},
	})
	use({
		"L3MON4D3/LuaSnip",
	})

	use("nvim-lua/plenary.nvim")
	use("jose-elias-alvarez/null-ls.nvim")
	use("lukas-reineke/lsp-format.nvim")
	use("jay-babu/mason-null-ls.nvim")
	use("nvim-telescope/telescope.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })
	use({ "kylechui/nvim-surround" })
	use({ "windwp/nvim-ts-autotag" })
	use({ "nvim-treesitter/nvim-tree-docs" })

	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		auto_install = true,
	})
	use({ "nvim-tree/nvim-web-devicons" })
end)

require("key_bindings")
require("opts")

require("nvim-treesitter.configs").setup({
	tree_docs = { enable = true },
})

require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the four listed parsers should always be installed)
	ensure_installed = { "python", "c", "vim", "help" },
	auto_install = true,
	highlight = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
})

require("mason").setup({})

local cmp = require("cmp")

cmp.setup({

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "buffer" },
	}),
	mapping = cmp.mapping.preset.insert({
		["<C-f>"] = cmp.mapping.scroll_docs(-4),
		["<C-b>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<Enter>"] = cmp.mapping.confirm({ select = true }),
	}),
})

-- Languages
require("langs.lua.init")
require("langs.rust.init")
require("langs.javascript.init")
require("langs.css.init")
require("langs.html.init")
-- Plugins
require("plugins.telescope.init")
require("plugins.gitsigns.init")
require("plugins.lualine.init")
require("plugins.bufferline.init")
require("plugins.trouble.init")

require("nvim-surround").setup({})
require("nvim-web-devicons").setup({})
