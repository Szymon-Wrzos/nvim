local create_snippet = require("snippets.create_printing_snippet")

local query = [[
(
 field (identifier) @name
 (function_call (identifier) @name (arguments (function_definition)))
)
( 
  assignment_statement (
    (variable_list (identifier) @name)
    (expression_list (function_definition))
  )
)
(function_declaration (identifier) @name (#set! "fetch_last" "true"))
]]

local breakpoints = {
	"field",
	"assignment_statement",
	"function_declaration",
}

--- @type string
local path_to_dir = vim.fn.getcwd()

local format = ""
if path_to_dir:find(".config/nvim") ~= nil then
	format = [[vim.print("[{function_name}]", {var})]]
else
	format = [[print("[{function_name}]", {var})]]
end

local snippet = create_snippet({
	language = "lua",
	format = format,
	query = query,
	breakpoints = breakpoints,
	program_node_name = "chunk",
})

return snippet
