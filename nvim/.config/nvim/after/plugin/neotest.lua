require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
  }
})

-- Keymaps for neotest
vim.keymap.set('n', '<leader>tt', function() require("neotest").run.run() end, { desc = "Run nearest test" })
vim.keymap.set('n', '<leader>tf', function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run current file" })
vim.keymap.set('n', '<leader>td', function() require("neotest").run.run({strategy = "dap"}) end, { desc = "Debug nearest test" })
vim.keymap.set('n', '<leader>ts', function() require("neotest").summary.toggle() end, { desc = "Toggle test summary" })
vim.keymap.set('n', '<leader>to', function() require("neotest").output.open({ enter = true }) end, { desc = "Open test output" })
vim.keymap.set('n', '<leader>tO', function() require("neotest").output_panel.toggle() end, { desc = "Toggle output panel" })
