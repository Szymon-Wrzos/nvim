local M = {}

M.treesitter = { "json" }

M.lspconfig = {
	{
		lsp = "jsonls",
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = false,
			},
		},
	},
}

M.mason.lspconfig = {
	"jsonls",
}

M.mason.null_ls = {
	"jsonlint",
	"prettierd",
}

M.null_ls = {
	formatter = { { program = "markdownlint", with = { filetypes = { "json" } } } },
	diagnostics = { { program = "jsonlint" } },
}
