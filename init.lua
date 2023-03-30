require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use("savq/melange-nvim")
	use("kevinhwang91/rnvimr")
	use("nvim-treesitter/nvim-treesitter")

	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")

	use("b0o/schemastore.nvim")
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
	use({ "nvim-treesitter/nvim-tree-docs" })

	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
	})
	use({ "nvim-tree/nvim-web-devicons" })
	use({ "windwp/nvim-ts-autotag" })
	use({ "windwp/nvim-spectre" })
	use({
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	})
	use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
	use({ "terrortylor/nvim-comment" })
	use({ "brenoprata10/nvim-highlight-colors" })
	use({ "nvim-treesitter/playground" })
end)

require("key_bindings")
require("opts")

require("nvim-treesitter.configs").setup({
	tree_docs = { enable = true },
})

require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the four listed parsers should always be installed)
	ensure_installed = { "c", "vim", "help", "markdown", "markdown_inline" },
	auto_install = true,
	highlight = {
		enable = true,
	},
})

require("mason").setup({})
-- Plugins setup
require("plugins.telescope.init")
require("plugins.gitsigns.init")
require("plugins.lualine.init")
require("plugins.bufferline.init")
require("plugins.trouble.init")
require("plugins.cmp.init")
require("plugins.spectre.init")

-- Languages setup
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.completion.luasnip,
	},
	on_attach = require("lsp-format").on_attach,
})

require("langs.lua.init")
require("langs.rust.init")
require("langs.javascript.init")
require("langs.css.init")
require("langs.html.init")
require("langs.tailwindcss.init")
require("langs.python.init")
require("langs.json.init")
require("langs.yaml.init")
require("langs.markdown.init")
require("langs.graphql.init")

require("nvim-web-devicons").setup({})
require("nvim-ts-autotag").setup()

require("neogit").setup({})
require("nvim_comment").setup({})
require("nvim-highlight-colors").setup({})

-- Snippets
require("snippets.javascript.init")
