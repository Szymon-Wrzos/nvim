local M = {}

M.init = function()
	require("spectre").setup({
		live_update = true,
	})
end
M.config = {
	"windwp/nvim-spectre",
	keys = {
		{
			"<leader>S",
			'<cmd>lua require("spectre").open()<CR>',
			desc = "Open [S]pectre",
		},
		{
			"<leader>sw",
			'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
			desc = "[s]earch current [w]ord",
		},
		{
			"<leader>sf",
			'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
			desc = "[s]earch in current [f]ile",
		},
		config = function()
			M.init()
		end,
	},
}
return M
