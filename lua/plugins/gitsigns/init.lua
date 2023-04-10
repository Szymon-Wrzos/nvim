require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 10,
		ignore_whitespace = false,
	},

	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
})
