local create_snippet = require("snippets.create_printing_snippet")

local query = [[
(assignment_statement (variable_list (identifier) @name))]]

local breakpoints = {
	"assignment_statement",
}

local snippet = create_snippet("lua", [[vim.print("{function_name}","{var}")]], query, breakpoints)

return snippet
