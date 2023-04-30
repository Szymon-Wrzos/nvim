local luasnip = require("luasnip")

local react_component_snippet = require("snippets.javascript.react.react_component")
local use_state = require("snippets.javascript.react.use_state")

local console = require("snippets.javascript.console")

local react_snippets = {
	react_component_snippet,
	use_state,
	console,
}

luasnip.add_snippets("typescriptreact", react_snippets)
luasnip.add_snippets("javascriptreact", react_snippets)
luasnip.add_snippets("javascript", react_snippets)
luasnip.add_snippets("typescript", react_snippets)
