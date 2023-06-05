vim.cmd([[ packadd packer.nvim ]])
require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use("savq/melange-nvim")
	use("nvim-tree/nvim-tree.lua")
	use("nvim-treesitter/nvim-treesitter")

	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")

	use("b0o/schemastore.nvim")
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
			{ "jcha0713/cmp-tw2css", after = "nvim-cmp" },
		},
	})
	use({
		"L3MON4D3/LuaSnip",
	})
	use("onsails/lspkind.nvim")
	use("nvim-lua/plenary.nvim")
	use("lukas-reineke/lsp-format.nvim")
	use("jose-elias-alvarez/null-ls.nvim")
	use("jay-babu/mason-null-ls.nvim")
	use("nvim-telescope/telescope.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({
		"lewis6991/gitsigns.nvim",
	})
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })
	use({ "nvim-treesitter/nvim-tree-docs" })

	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
	})
	use({ "nvim-tree/nvim-web-devicons" })
	use({ "windwp/nvim-ts-autotag", requires = { "nvim-treesitter/nvim-treesitter" } })
	use({ "windwp/nvim-spectre" })
	use({
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	})
	use({ "terrortylor/nvim-comment" })
	use({ "nvim-treesitter/playground", requires = { "nvim-treesitter/nvim-treesitter" } })
	use("rmehri01/onenord.nvim")
	use({
		"jcdickinson/codeium.nvim",
	})
	use({
		"kdheepak/lazygit.nvim",
	})
	use({
		"gelguy/wilder.nvim",
	})
	use({ "romgrk/fzy-lua-native" })
end)

require("key_bindings")
require("opts")

require("mason").setup({})
-- Plugins setup
require("plugins.treesitter.init")
require("plugins.telescope.init")
require("plugins.gitsigns.init")
require("plugins.lualine.init")
require("plugins.bufferline.init")
require("plugins.trouble.init")
require("plugins.cmp.init")
require("plugins.spectre.init")
require("plugins.nvim_tree.init")
require("plugins.codeium.init")
require("plugins.wilder.init")
-- require("plugins.wilder.init")
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
require("langs.vue.init")

require("nvim-web-devicons").setup({})
require("nvim-ts-autotag").setup()

require("nvim_comment").setup({})
-- Snippets
require("snippets.javascript.init")
require("snippets.css.init")

require("plugins.colorscheme.init")
