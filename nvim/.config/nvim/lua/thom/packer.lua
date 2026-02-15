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

  -- AI agent plugin
  use {
	  "ThePrimeagen/99",
	  config = function()
		  local _99 = require("99")
		  local Providers = require("99.providers")
		  _99.setup({
          provider = Providers.ClaudeCodeProvider,
            model = "claude-sonnet-4-5",

          completion = {
            custom_rules = {
              "scratch/custom_rules/",
            },

            files = {
            },
            },
		  })

		  -- Keymaps
		  vim.keymap.set("v", "<leader>9v", function()
			  _99.visual()
		  end)

		  --- if you have a request you dont want to make any changes, just cancel it
		  vim.keymap.set("v", "<leader>9s", function()
			  _99.stop_all_requests()
		  end)
	  end
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
  
  -- Auto formatting
  use {
    'stevearc/conform.nvim',
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
    end
  }

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

  -- Testing with Neotest
  use('nvim-neotest/nvim-nio')
  use('antoinemadec/FixCursorHold.nvim')
  use {
    'nvim-neotest/neotest',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/nvim-nio'
    }
  }
  use('nvim-neotest/neotest-python')

  -- Diagnostics and quickfix list
  use {
    'folke/trouble.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
      }
    end
  }

end)
