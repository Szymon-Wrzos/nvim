local luasnip = require("luasnip")
local sn = luasnip.snippet
local i = luasnip.insert_node
local t = luasnip.text_node
local c = luasnip.choice_node
local s = luasnip.snippet_node
local d = luasnip.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local ts = require("vim.treesitter")
local ts_query = require("vim.treesitter.query")

local function dump(o)
	if type(o) == "table" then
		local ss = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			ss = ss .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return ss .. "} "
	else
		return tostring(o)
	end
end

local function contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

--- @param node TSNode | nil
--- @returns TSNode | nil
local function seek_function_root(node, depth)
	if node == nil then
		return nil
	end

	local node_type = node:type()
	-- print(depth, node_type)
	local js_function_type = { "function_declaration", "variable_declarator" }
	if node_type == "program" then
		return node
	end

	if contains(js_function_type, node_type) then
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
	print(node:type())
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
			local data = get_data(function_root)
			return s(nil, { t(data) })
		end),
	})
)

return console
