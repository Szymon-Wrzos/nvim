local luasnip = require("luasnip")

local react_component_snippet = require("snippets.javascript.react.react_component")
local react_context_snippet = require("snippets.javascript.react.react_context")
local use_state = require("snippets.javascript.react.use_state")

local console = require("snippets.javascript.console")

local react_snippets = {
	react_component_snippet,
	react_context_snippet,
	use_state,
	console,
}

local js_snippets = {}

local ts_based_snippets = {
	console,
}

for key, val in pairs(react_snippets) do
	js_snippets[key] = val
end

for key, val in pairs(ts_based_snippets) do
	js_snippets[key] = val
end

luasnip.add_snippets("typescriptreact", react_snippets)
luasnip.add_snippets("javascriptreact", react_snippets)
luasnip.add_snippets("javascript", js_snippets)
luasnip.add_snippets("typescript", js_snippets)
