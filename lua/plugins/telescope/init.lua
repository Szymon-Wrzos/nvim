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
		local max_size = 1024 * 200 -- 200kB max
		if stat.size > max_size then
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
