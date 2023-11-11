local M = {}

M.init = function()
	require("fzf-lua").setup({ "telescope", winopts = { preview = { default = "bat" } } })
	vim.keymap.set(
		"n",
		"<leader>ff",
		"<cmd>lua require('fzf-lua').files({ cmd = 'fd --type file'})<CR>",
		{ silent = true }
	)
	vim.keymap.set("n", "<leader>fg", "<cmd>lua require('fzf-lua').live_grep({cmd = 'rg'})<CR>", { silent = true })
end

M.config = {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons", { "junegunn/fzf", build = "./install --bin" } },
	event = "VeryLazy",
	config = function()
		M.init()
	end,
}
return M
