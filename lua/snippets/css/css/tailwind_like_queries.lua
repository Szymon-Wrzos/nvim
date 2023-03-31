local sizes_table = {
	["sm"] = 640,
	["md"] = 768,
	["lg"] = 1024,
	["xl"] = 1280,
	["2xl"] = 1536,
}

local luasnip = require("luasnip")
local sn = luasnip.snippet
local i = luasnip.insert_node
local t = luasnip.t
local s = luasnip.snippet_node
local d = luasnip.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local construction = [[
  @media screen and (min-width: {}px) {{
    {}
  }}
]]

local snippets = {}

for class_name, width in pairs(sizes_table) do
	local snippet = sn(
		{ trig = class_name .. ":", dscr = "Media query for " .. tostring(width) .. "px" },
		fmt(construction, { d(1, function()
			return s(nil, t(tostring(width)))
		end), i(2, "") })
	)
	table.insert(snippets, snippet)
end

return snippets
