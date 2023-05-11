local telescope = require("telescope")
local builtin = require("telescope.builtin")
local previewers = require("telescope.previewers")

local new_maker = function(filepath, bufnr, opts)
	opts = opts or {}

	filepath = vim.fn.expand(filepath)
	vim.loop.fs_stat(filepath, function(_, stat)
		if not stat then
			return
		end
		if stat.size > 102400 then
			return
		else
			previewers.buffer_previewer_maker(filepath, bufnr, opts)
		end
	end)
end

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fj", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>fn", builtin.lsp_definitions, {})
telescope.load_extension("luasnip")
telescope.setup({
	defaults = {
		file_ignore_patterns = { ".git/.+", "node_modules", "dist" },
		buffer_previewer_maker = new_maker,
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
})
