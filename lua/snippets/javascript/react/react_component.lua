local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt

local snip = luasnip.snippet
local node = luasnip.snippet_node
local text = luasnip.text_node
local insert = luasnip.insert_node
local func = luasnip.function_node
local choice = luasnip.choice_node
local dynamicn = luasnip.dynamic_node

local export_method = {
	insert(1),
	text(" "),
}
return snip({
	dscr = "React component boilerplate",
	trig = "ComBoi",
	name = "React component",
}, { export_method })
