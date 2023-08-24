local langs_table = require("utils.langs_table")

local mason = {
	"williamboman/mason.nvim",
	event = "VeryLazy",
	config = function()
		require("mason").setup()
	end,
}

local mason_lspconfig = {

	"williamboman/mason-lspconfig.nvim",
	event = "VeryLazy",
	config = function()
		local mason_lsp = require("mason-lspconfig")
		for _, data in pairs(langs_table) do
			mason_lsp.setup({
				ensure_installed = data.mason.lspconfig,
				automatic_installation = true,
			})
		end
	end,

	dependencies = {
		"b0o/schemastore.nvim",
		mason,
	},
}

local lspconfig = {
	"neovim/nvim-lspconfig",
	dependencies = { mason_lspconfig },
	event = "VeryLazy",
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		for _, data in pairs(langs_table) do
			for _, lspdata in pairs(data.lspconfig) do
				lspconfig[lspdata.lsp].setup({
					capabilities = capabilities,
					settings = lspdata.settings,
				})
			end
		end
	end,
}
return lspconfig
