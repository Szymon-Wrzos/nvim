local M = {}

M.treesitter = {
	"css",
	"scss",
}

M.lspconfig = {
	 { lsp = "cssls" }, { lsp = "cssmodules_ls" } ,
}

M.mason = {}

M.mason.lspconfig = {
	"cssls",
	"cssmodules_ls",
}

M.mason.null_ls = {
	"prettierd",
	"stylelint",
}

M.null_ls = {
	formatting = { { program = "prettierd", with = { filetypes = { "css", "sass", "scss" } } } },
}
return M
