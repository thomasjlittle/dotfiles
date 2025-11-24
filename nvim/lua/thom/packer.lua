-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({
	  'Mofiqul/vscode.nvim',
	  as = 'vscode',
	  config = function()
		  vim.cmd('colorscheme vscode')
	  end
  })

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-lua/plenary.nvim')
  use {
	  "ThePrimeagen/harpoon",
	  branch = "harpoon2",
	  requires = { {"nvim-lua/plenary.nvim"} }
  }
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('williamboman/mason.nvim')
  use('williamboman/mason-lspconfig.nvim')
  use('neovim/nvim-lspconfig')

  -- Autocompletion
  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-cmdline')

  -- Cellular Automaton animations
  use('eandrju/cellular-automaton.nvim')

  -- Debugger
  use('mfussenegger/nvim-dap')
  use('mfussenegger/nvim-dap-python')
  use {
      "igorlfs/nvim-dap-view",
      config = function()
        require("dap-view").setup({})
      end,
    }


end)

