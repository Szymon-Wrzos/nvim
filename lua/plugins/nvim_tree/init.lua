local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5 -- You can change this too

local function open_tab_silent(node)
	local api = require("nvim-tree.api")

	api.node.open.tab(node)
	vim.cmd.tabprev()
end

local tree_actions = {
	{
		name = "Create node",
		handler = require("nvim-tree.api").fs.create,
	},
	{
		name = "Remove node",
		handler = require("nvim-tree.api").fs.remove,
	},
	{
		name = "Trash node",
		handler = require("nvim-tree.api").fs.trash,
	},
	{
		name = "Rename node",
		handler = require("nvim-tree.api").fs.rename,
	},
	{
		name = "Fully rename node",
		handler = require("nvim-tree.api").fs.rename_sub,
	},
	{
		name = "Copy",
		handler = require("nvim-tree.api").fs.copy.node,
	},

	-- ... other custom actions you may want to display in the menu
}
local function tree_actions_menu(node)
	local entry_maker = function(menu_item)
		return {
			value = menu_item,
			ordinal = menu_item.name,
			display = menu_item.name,
		}
	end

	local finder = require("telescope.finders").new_table({
		results = tree_actions,
		entry_maker = entry_maker,
	})

	local sorter = require("telescope.sorters").get_generic_fuzzy_sorter()

	local default_options = {
		finder = finder,
		sorter = sorter,
		attach_mappings = function(prompt_buffer_number)
			local actions = require("telescope.actions")

			-- On item select
			actions.select_default:replace(function()
				local state = require("telescope.actions.state")
				local selection = state.get_selected_entry()
				-- Closing the picker
				actions.close(prompt_buffer_number)
				-- Executing the callback
				selection.value.handler(node)
			end)

			-- The following actions are disabled in this example
			-- You may want to map them too depending on your needs though
			actions.add_selection:replace(function() end)
			actions.remove_selection:replace(function() end)
			actions.toggle_selection:replace(function() end)
			actions.select_all:replace(function() end)
			actions.drop_all:replace(function() end)
			actions.toggle_all:replace(function() end)

			return true
		end,
	}

	-- Opening the menu
	require("telescope.pickers").new({ prompt_title = "Tree menu" }, default_options):find()
end
require("nvim-tree").setup({
	disable_netrw = false,
	update_focused_file = { enable = true, update_root = true },
	view = {
		mappings = {
			list = {
				{ key = "T", action = "Open Tab Silently", action_cb = open_tab_silent },
        { key = "TAM", action = "Tree actions", action_cb = tree_actions_menu}
			},
		},

		hide_root_folder = true,
		width = function()
			return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
		end,

		float = {
			enable = true,
			quit_on_focus_loss = false,
			open_win_config = function()
				local screen_w = vim.opt.columns:get()
				local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
				local window_w = screen_w * WIDTH_RATIO
				local window_h = screen_h * HEIGHT_RATIO
				local window_w_int = math.floor(window_w)
				local window_h_int = math.floor(window_h)
				local center_x = (screen_w - window_w) / 2
				local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
				return {
					border = "rounded",
					relative = "editor",
					row = center_y,
					col = center_x,
					width = window_w_int,
					height = window_h_int,
				}
			end,
		},
	},
})
