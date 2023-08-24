local lspconfig = require("lazy.config_parts.mason_lspconfig")
local null_ls = require("lazy.config_parts.mason_null_ls")

local result = { lspconfig, null_ls }

return result
