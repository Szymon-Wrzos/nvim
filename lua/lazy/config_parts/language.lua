local mason_lspconfig = require("lazy.config_parts.mason_lspconfig")
local null_ls_lspconfig = require("lazy.config_parts.mason_null_ls")


local mason = {
	"williamboman/mason.nvim",
	event = "VeryLazy",
	dependencies = {
		mason_lspconfig,
    null_ls_lspconfig,
	},
	config = function()
		require("mason").setup()
	end,
}

return mason
