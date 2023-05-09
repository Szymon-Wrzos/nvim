local telescope = require("telescope")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fj", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>fn", builtin.lsp_definitions, {})
telescope.load_extension("luasnip")
telescope.setup({
	defaults = {
		file_ignore_patterns = { ".git", "node_modules", "dist" },
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
})
