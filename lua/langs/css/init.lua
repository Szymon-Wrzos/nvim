local M = {}

M.treesitter = {
	"css",
	"scss",
}

M.lspconfig = {
	{ { lsp = "cssls" }, { lsp = "css_modules" } },
}

M.mason.lspconfig = {
	"cssls",
	"css_modules",
}

M.mason.null_ls = {
	"prettierd",
	"stylelint",
}

M.null_ls = {
	formatting = { { program = "prettierd", with = { filetypes = { "css", "sass", "scss" } } } },
}
return M
