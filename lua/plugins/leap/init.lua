local M = {}

M.init = function()
	require("leap").add_default_mappings()
end

M.config = {
	"ggandor/leap.nvim",
	keys = { { "s" }, { "S" }, { "f" }, { "F" } },
	dependencies = {
		"tpope/vim-repeat",
	},
	config = function()
		M.init()
	end,
}

return M
