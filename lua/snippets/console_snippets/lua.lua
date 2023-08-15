local create_snippet = require("snippets.create_printing_snippet")

local query = [[
( 
  assignment_statement (
    (variable_list (identifier) @name)
    (expression_list (function_definition))
  )
)
(function_declaration (identifier) @name)
]]

local breakpoints = {
	"assignment_statement",
	"function_declaration",
}

local path = require("plenary.path")
--- @type string
local path_to_dir = path:new():parents()[1]

local format = ""
if path_to_dir:find(".config") ~= nil then
	format = [[vim.print("{function_name}", {var})]]
else
	format = [[print("{function_name}", {var})]]
end

local snippet = create_snippet("lua", format, query, breakpoints)

return snippet
