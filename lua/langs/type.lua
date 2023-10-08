--- @class LSPConfig
--- @field lsp string
--- @field settings table?
--- @field on_attach function?

--- @class Mason
--- @field lspconfig string[]
--- @field null_ls string[]

--- @class NullLSWith
--- @field args string[]?
--- @field filetypes string[]?

--- @class NullLSEntry
--- @field program string
--- @field with NullLSWith?

--- @class NullLS
--- @field formatting NullLSEntry[]?
--- @field diagnostics NullLSEntry[]?
--- @field code_actions NullLSEntry[]?
--- @field rest any[]?

--- @class DAPConfigurationEntry
--- @field type string
--- @field request string
--- @field name string

--- @class DAP
--- @field names string[]
--- @field mason string[]
--- @field adapter function
--- @field config DAPConfigurationEntry[]

--- @class LanguageModule
--- @field treesitter string[]
--- @field lspconfig LSPConfig[]
--- @field mason Mason
--- @field null_ls NullLS
--- @field dap DAP?
