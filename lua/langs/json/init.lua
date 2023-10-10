local M = {}

M.treesitter = { "json" }

M.lspconfig = {
	{
		lsp = "jsonls",
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
			},
		},
	},
}

M.mason = {}

M.mason.lspconfig = {
	"jsonls",
}

M.mason.null_ls = {
	"jsonlint",
	"prettierd",
}

M.null_ls = {
	formatting = { { program = "prettierd", with = { filetypes = { "json" } } } },
	diagnostics = { { program = "jsonlint" } },
}
return M
