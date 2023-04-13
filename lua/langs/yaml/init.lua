require("nvim-treesitter.configs").setup({
	ensure_installed = { "yaml" },
	auto_install = true,
	highlight = {
		enable = true,
	},
})

require("mason-lspconfig").setup({
	ensure_installed = { "yamlls" },
})

require("mason-null-ls").setup({
	ensure_installed = { "yamllint", "prettierd", "yamlfmt" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["yamlls"].setup({
	capabilities = capabilities,

	settings = {
		yaml = {
			schemas = require("schemastore").json.schemas(),
			validate = false,
		},
	},
})

local null_ls = require("null-ls")

null_ls.register({
	sources = {
		null_ls.builtins.diagnostics.yamllint.with({
			args = {
				"--format",
				"parsable",
				"--config-file",
				os.getenv("HOME") .. "/.config/nvim/lua/langs/yaml/yamllint_config.yml",
				"--no-warnings",
				"-",
			},
		}),
	},
	debug = true,
})
