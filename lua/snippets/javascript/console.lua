local luasnip = require("luasnip")
local sn = luasnip.snippet
local t = luasnip.text_node
local s = luasnip.snippet_node
local d = luasnip.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local ts = require("vim.treesitter")
local ts_query = require("vim.treesitter.query")

--- @param node TSNode | nil
--- @returns TSNode | nil
local function seek_function_root(node, depth)
	if node == nil then
		return nil
	end

	local node_type = node:type()
	print(depth, node_type)
	local js_function_type = { "function_declaration", "variable_declarator" }

	if vim.tbl_contains(js_function_type, node_type) then
		return node
	end

	local parent = node:parent()

	return seek_function_root(parent, depth + 1)
end

--- @param node TSNode | nil
local function get_data(node)
	if node == nil then
		return nil
	end
	if node:type() == "program" then
		return "global"
	end
	local parsed_query = ts_query.parse("javascript", [[(identifier) @name]])
	-- print("[get_data]")
	for _, parsed_node, _ in parsed_query:iter_captures(node, 0, node:start(), node:end_()) do
		return ts.get_node_text(parsed_node, 0)
	end
end

local console = sn(
	"con",
	fmt([[ console.log("[{function_name}]","{test}")]], {
		test = t(""),
		function_name = d(1, function()
			local function_root = seek_function_root(ts:get_node(), 0)
			local data = function_root ~= nil and get_data(function_root) or ""
			return s(nil, { t(data) })
		end),
	})
)

return console
