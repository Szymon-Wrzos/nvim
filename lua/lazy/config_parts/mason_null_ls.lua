local langs_table = require("utils.langs_table")

local mason_null_ls = {

	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					-- Languages setup
					local null_ls = require("null-ls")
					null_ls.setup({
						sources = {
							null_ls.builtins.completion.luasnip,
						},
						on_attach = require("lsp-format").on_attach,
					})
				end,
			},
		},
		config = function()
			local null_ls = require("null-ls")
			for _, data in pairs(langs_table) do
				for type, null_ls_data in pairs(data.null_ls) do
					local sources = {}
					for _, val in pairs(null_ls_data) do
						local null_ls_builtin = null_ls.builtins[type][val.program]
						table.insert(sources, val.with and null_ls_builtin.with(val.with) or null_ls_builtin)
					end
					null_ls.register({ sources = sources })
				end
			end
		end,
	},
}

return mason_null_ls
