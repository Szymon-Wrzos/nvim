local M = {}

M.init = function()
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

	vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [f]iles" })
	vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind [g]reps" })
	vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [b]uffers" })
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [h]elp" })
	vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "[F]ind [r]eferences" })
	vim.keymap.set("n", "<leader>fn", builtin.lsp_definitions, { desc = "[F]ind defi[n]itions" })
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
end

return M
