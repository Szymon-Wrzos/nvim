-- Create lua snippet creating context of ReactJS

local luasnip = require("luasnip")
local i = luasnip.insert_node
local c = luasnip.choice_node
local t = luasnip.text_node
local f = luasnip.function_node
local sn = luasnip.snippet
local s = luasnip.snippet_node
local l = luasnip.label
local d = luasnip.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local react_boilerplate = sn(
	"ContextBoi",
	fmt(
		[[
  import React, {{ createContext }} from 'react';
  import PropTypes from 'prop-types';

  /**
   * @type {{ React.Context<any> }}
   */
  export const {context_name}Context = createContext();
  
  const {context_name}Provider = ({{ children }}) => {{
    {}/* Your code goes here */
    return <{context_name}Context.Provider values={{{{}}}}>{{children}}</{context_name}Context.Provider>;
  }};

  {context_name}Provider.propTypes = {{
    children: PropTypes.node.isRequired,
  }};

  {export_method};
]],
		{
			context_name = i(1, "Context"),
			export_method = d(2, function(args)
				local component_name = args[1][1]
				return s(nil, {
					c(1, {
						i(1, "export default " .. component_name .. "Provider"),
						i(2, "export { " .. component_name .. "Provider }"),
					}),
				})
			end, { 1 }),
			i(0),
		},
		{
			repeat_duplicates = true,
		}
	)
)

return react_boilerplate