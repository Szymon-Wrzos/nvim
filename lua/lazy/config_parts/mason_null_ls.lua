local mason = {
	"williamboman/mason.nvim",
	event = "VeryLazy",
	config = function()
		require("mason").setup()
	end,
}

local function inArray(arr, element) -- function to check if something is in an array
	for _, value in ipairs(arr) do -- ipairs is the recommended iterator for looping through arrays
		if value == element then
			return true
		end
	end
	return false -- if no element was found, return false
end

local function removeDuplicates(arr)
	local newArray = {} -- new array that will be arr, but without duplicates
	for _, element in ipairs(arr) do
		if not inArray(newArray, element) then -- making sure we had not added it yet to prevent duplicates
			table.insert(newArray, element)
		end
	end
	return newArray -- returning the new, duplicate removed array
end

local mason_null_ls = {
	"jay-babu/mason-null-ls.nvim",

	event = "VeryLazy",
	config = function()
		local langs_table = require("utils.langs_table")
		local null_ls = require("null-ls")

		local ensure_installed = {}
		for _, val in pairs(langs_table) do
			table.insert(ensure_installed, val.mason.null_ls)
		end
		local flattened_table = vim.tbl_flatten(ensure_installed)
		local deduplicated_table = removeDuplicates(flattened_table)
		require("mason-null-ls").setup({ ensure_installed = deduplicated_table })

		local sources = {}

		for _, data in pairs(langs_table) do
			for type, null_ls_data in pairs(data.null_ls) do
				for _, val in pairs(null_ls_data) do
					local null_ls_builtin = null_ls.builtins[type][val.program]
					table.insert(sources, val.with and null_ls_builtin.with(val.with) or null_ls_builtin)
				end
			end
		end

		null_ls.register({ sources = sources })
	end,
	dependencies = { mason },
}
local null_ls = {
	"jose-elias-alvarez/null-ls.nvim",

	event = "VeryLazy",
	config = function()
		-- Languages setup
		local null_ls = require("null-ls")
		local null_ls_data = {}
		local langs_table = require("utils.langs_table")
		for _, val in pairs(langs_table) do
			table.insert(null_ls_data, val.mason.null_ls)
		end
		null_ls.setup({
			sources = {
				null_ls.builtins.completion.luasnip,
			},
			on_attach = require("lsp-format").on_attach,
		})
	end,
	dependencies = {
		mason_null_ls,
		{
			"lukas-reineke/lsp-format.nvim",
		},
		{ "jose-elias-alvarez/typescript.nvim" },
	},
}

return null_ls
