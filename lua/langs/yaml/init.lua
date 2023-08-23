local M = {}

M.treesitter = { "yaml" }

M.lspconfig = {
	{
		lsp = "yamlls",
	},
}

M.mason = {}

M.mason.lspconfig = {
	"yamlls",
}

M.mason.null_ls = {
	"yamllint",
	"yamlfmt",
	"prettierd",
}

M.null_ls = {
	formatter = { { program = "prettierd", with = { filetypes = { "yaml" } } } },
	diagnostics = {
		{
			program = "yamllint",
			with = {
				args = {
					"--format",
					"parsable",
					"--config-file",
					os.getenv("HOME") .. "/.config/nvim/lua/langs/yaml/yamllint_config.yml",
					"--no-warnings",
					"-",
				},
			},
		},
	},
}

return M
