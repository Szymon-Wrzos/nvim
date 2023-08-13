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

local mappings = {
	["javascript"] = "javascript",
	["javascriptreact"] = "javascript",
	["typescript"] = "typescript",
	["typescriptreact"] = "tsx",
}

local function all_trim(str)
	return str:match("^%s*(.-)%s*$")
end

local function get_query_data()
	local filetype = vim.bo.filetype
	local query_data = {
		["variable_declarator"] = {
			["identifier"] = "@name",
		},
		["function_declaration"] = {
			["identifier"] = "@name",
		},
		["method_definition"] = {
			["property_identifier"] = "@name",
			["private_property_identifier"] = "@name",
		},
	}

	if filetype == "typescript" or filetype == "typescriptreact" then
		local typescript_query_data = {
			["public_field_definition"] = {
				["property_identifier"] = "@name",
				["private_property_identifier"] = "@name",
			},
		}
		for key, data in pairs(typescript_query_data) do
			query_data[key] = data
		end
	elseif filetype == "javascript" or filetype == "javascriptreact" then
		local javascript_query_data = {
			["field_definition"] = {
				["property_identifier"] = "@name",
			},
		}
		for key, data in pairs(javascript_query_data) do
			query_data[key] = data
		end
	end

	--- @type string[]
	local breakpoints = {}
	local full_query = [[]]
	for key, val in pairs(query_data) do
		table.insert(breakpoints, key)
		for inner_key, inner_val in pairs(val) do
			full_query = full_query .. "(" .. key .. " (" .. inner_key .. ") " .. inner_val .. ")\n"
		end
	end
	return breakpoints, full_query
end

--- @param node TSNode | nil
--- @param ts_elements table<string>
--- @returns TSNode | nil
local function seek_function_root(node, ts_elements)
	if node == nil then
		return nil
	end
	local node_type = node:type()
	if vim.tbl_contains(ts_elements, node_type) or node_type == "program" then
		return node
	end

	local parent = node:parent()

	return seek_function_root(parent, ts_elements)
end

--- @param node TSNode | nil
-- TODO: This has potential to work in other langauges - just dehardcode it someday
local function get_data(node)
	if node == nil then
		return nil
	end
	local node_type = node:type()
	if node_type == "program" then
		return "global"
	end
	local _, full_query = get_query_data()
	local parsed_query = ts_query.parse(mappings[vim.bo.filetype], full_query)
	for _, parsed_node, _ in parsed_query:iter_captures(node, 0, node:start(), node:end_()) do
		return ts.get_node_text(parsed_node, 0)
	end
end

local console = sn(
	"con",
	fmt([[ console.log("[{function_name}]",{var})]], {
		function_name = d(1, function(args, snip)
			local pos_begin = snip.nodes[6].mark:pos_begin()
			local pos_end = snip.nodes[6].mark:pos_end()
			local parser = vim.treesitter.get_parser(0, mappings[vim.bo.filetype])
			local tstree = parser:parse()

			local ts_node =
				tstree[1]:root():named_descendant_for_range(pos_begin[1], pos_begin[2], pos_end[1], pos_end[2])

			local checked_value = all_trim(args[1][1])
			local breakpoints, _ = get_query_data()
			local function_root = seek_function_root(ts_node, breakpoints)
			local data = function_root ~= nil and get_data(function_root) or ""
			local output = checked_value ~= "" and t(data .. " - " .. checked_value) or t(data)
			return s(nil, { output })
		end, { 2 }),
		var = i(2),
	})
)

return console
