local M = {}

M.treesitter = { "json" }

M.lspconfig = {
	{
		lsp = "jsonls",
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
	formatter = { { program = "markdownlint", with = { filetypes = { "json" } } } },
	diagnostics = { { program = "jsonlint" } },
}
return M
