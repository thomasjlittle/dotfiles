-- Add Mason bin to PATH
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
vim.env.PATH = mason_bin .. ":" .. vim.env.PATH

-- Set border style for all floating windows globally (Neovim 0.11+)
vim.o.winborder = "single"

-- Configure diagnostics
vim.diagnostic.config({
	-- Enable virtual text (inline messages)
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
	},
	-- Show signs in the sign column
	signs = true,
	-- Update diagnostics in insert mode
	update_in_insert = false,
	-- Underline errors/warnings
	underline = true,
	-- Sort by severity
	severity_sort = true,
	-- Floating window configuration
	float = {
		border = "single",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- Setup pyright
vim.lsp.config.pyright = {
	cmd = { mason_bin .. '/pyright-langserver', '--stdio' },
	filetypes = { 'python' },
	root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "standard",
			}
		}
	}
}

-- Setup ruff
vim.lsp.config.ruff = {
	cmd = { mason_bin .. '/ruff', 'server' },
	filetypes = { 'python' },
	root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
}

-- Enable LSP servers for Python files
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'python',
	callback = function(args)
		vim.lsp.enable('pyright')
		vim.lsp.enable('ruff')
	end,
})

-- LSP Keybindings (when LSP attaches to buffer)
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = {buffer = event.buf}

		-- Go to definition
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

		-- Show hover documentation
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

		-- Show diagnostics in floating window
		vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)

		-- Rename symbol
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

		-- Code actions
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

		-- Format on save for Python files with ruff
		if vim.bo[event.buf].filetype == 'python' then
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = event.buf,
				callback = function()
					vim.lsp.buf.format({ name = 'ruff' })
				end,
			})
		end
	end
})
