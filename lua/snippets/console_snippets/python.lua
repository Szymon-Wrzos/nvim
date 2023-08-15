local create_snippet = require("snippets.create_printing_snippet")

local query = [[
(function_definition (identifier) @name)
]]

local breakpoints = {
	"function_definition",
}

local format = [[print("[{function_name}]", {var})]]

local snippet = create_snippet({
	language = "python",
	format = format,
	query = query,
	breakpoints = breakpoints,
	program_node_name = "module",
})

return snippet
