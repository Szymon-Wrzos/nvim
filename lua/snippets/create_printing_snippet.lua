local luasnip = require("luasnip")
local i = luasnip.insert_node
local sn = luasnip.snippet
local t = luasnip.text_node
local s = luasnip.snippet_node
local d = luasnip.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
--- @type TreesitterModule
local ts = vim.treesitter
local ts_query = ts.query

--- Function for creating printing snippet for luasnip
--- In idea, snippet prints printing function for language with name of function in the nearest scope
--- @param language string
--- @param format string - format string, should contain {function_name} and {var}. Example:
---```lua
---    [[console.log("[{function_name}]",{var})]]
---```
--- @param query string - treesitter query for fetching function name
--- @param breakpoints string[] - breakpoints for treesitter when it should check nearest function name in scope
--- @param parser_name string | nil - parser of language if different than filetypes (Exists because of jsx and tsx nvim poor handling).
local create_printing_snippet = function(language, format, query, breakpoints, parser_name)
	local function all_trim(str)
		return str:match("^%s*(.-)%s*$")
	end
	--- @param node TSNode | nil
	--- @param ts_elements table<string>
	--- @returns TSNode | nil
	local function seek_function_root(node, ts_elements)
		if node == nil then
			return nil
		end
		local node_type = node:type()

		vim.print("", node_type)
		if vim.tbl_contains(ts_elements, node_type) or node_type == "program" or node_type == "chunk" then
			return node
		end

		local parent = node:parent()

		return seek_function_root(parent, ts_elements)
	end

	--- @param node TSNode | nil
	local function get_node_text(node)
		if node == nil then
			return nil
		end
		local node_type = node:type()
		vim.print("", node_type)
		if node_type == "program" or node_type == "chunk" then
			return "global"
		end
		local parsed_query = ts_query.parse(parser_name or language, query)
		for _, parsed_node, _ in parsed_query:iter_captures(node, 0, node:start(), node:end_()) do
			return ts.get_node_text(parsed_node, 0)
		end
	end

	local console = sn(
		"con",
		fmt(format, {
			function_name = d(1, function(args, snip)
				local pos_begin = snip.nodes[6].mark:pos_begin()
				local pos_end = snip.nodes[6].mark:pos_end()
				local parser = vim.treesitter.get_parser(0, parser_name or language)
				local tstree = parser:parse()

				local ts_node =
					tstree[1]:root():named_descendant_for_range(pos_begin[1], pos_begin[2], pos_end[1], pos_end[2])

				local checked_value = all_trim(args[1][1])
				local function_root = seek_function_root(ts_node, breakpoints)
				local data = function_root ~= nil and get_node_text(function_root) or ""
				local output = checked_value ~= "" and t(data .. " - " .. checked_value) or t(data)
				return s(nil, { output })
			end, { 2 }),
			var = i(2),
		})
	)
	return console
end

return create_printing_snippet
