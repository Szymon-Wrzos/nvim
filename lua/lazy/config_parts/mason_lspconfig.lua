local langs_table = require("utils.langs_table")

local mason = {
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
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				"b0o/schemastore.nvim",
			},
			config = function()
				local lspconfig = require("lspconfig")
				local capabilities = require("cmp_nvim_lsp").default_capabilities()

				for _, data in pairs(langs_table) do
					for _, lspdata in pairs(data.lspconfig) do
						lspconfig[lspdata.lsp].setup({
						    capabilities = capabilities,
						    settings = lspdata.settings or {},
						})
					end
				end
			end,
		},
	},
}
return mason
