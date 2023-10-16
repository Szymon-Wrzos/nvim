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

		local langs_table = require("utils.langs_table")
		local mason_lspconfig_entries = {}
		for _, data in pairs(langs_table) do
			for _, lspdata in pairs(data.mason.lspconfig) do
				table.insert(mason_lspconfig_entries, lspdata)
			end
		end

		mason_lsp.setup({
			ensure_installed = mason_lspconfig_entries,
			automatic_installation = true,
		})
	end,

	dependencies = {
		mason,
	},
}

local lspconfig = {
	"neovim/nvim-lspconfig",
	dependencies = { mason_lspconfig, {
		"b0o/schemastore.nvim",
	} },
	priority = 700,
	event = "VeryLazy",
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local langs_table = require("utils.langs_table")
		for _, data in pairs(langs_table) do
			for _, lspdata in pairs(data.lspconfig) do
				local params = {
					capabilities = capabilities,
					settings = lspdata.settings,
				}
				lspconfig[lspdata.lsp].setup(params)
			end
		end
	end,
}
return lspconfig
