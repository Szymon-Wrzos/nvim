local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use {
  		'nvim-lualine/lualine.nvim',
  		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use 'ap/vim-css-color'
	use 'ethanholz/nvim-lastplace'
	use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}
	use {'sainnhe/everforest', disable = false, opt=false}
	use {'kevinhwang91/rnvimr'}

  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end
  })
  use {"neovim/nvim-lspconfig"}
	use { "simrat39/rust-tools.nvim" }
	use { "williamboman/mason.nvim" }
	use {"williamboman/mason-lspconfig.nvim" }
		
		-- Completion framework	
    use 'hrsh7th/nvim-cmp' 

    -- LSP completion source:
    use 'hrsh7th/cmp-nvim-lsp'

    -- Useful completion sources:
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'                             
    use 'hrsh7th/cmp-path'                              
    use 'hrsh7th/cmp-buffer'                            
    use 'hrsh7th/vim-vsnip'      
	vim.cmd[[colorscheme everforest]]

	if packer_bootstrap then
		require('packer').sync()
	end
end)

