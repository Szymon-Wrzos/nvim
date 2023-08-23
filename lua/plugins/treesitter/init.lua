local langs = require("utils.langs_table")

local ensure_installed = { "c", "vim", "markdown", "markdown_inline" }

for _, val in pairs(langs) do
	for _, entry in pairs(val.treesitter) do
		require("nvim-treesitter.configs").setup({

			ensure_installed = entry,
		})
	end
end

require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the four listed parsers should always be installed)
	ensure_installed = ensure_installed,
	modules = {},
	sync_install = true,
	ignore_install = {},
	auto_install = true,
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = { "BufWrite", "CursorHold" },
	},
	tree_docs = { enable = true },
})
