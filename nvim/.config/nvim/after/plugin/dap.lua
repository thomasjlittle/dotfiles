-- ~/.config/nvim/after/plugin/dap.lua

local dap = require('dap')
local dapview = require('dap-view')

-- 1. Setup nvim-dap-view
dapview.setup()

-- 2. Setup Python
-- Ensure you have installed debugpy: :MasonInstall debugpy
local mason_path = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python'
require('dap-python').setup(mason_path)

-- 2. THE RUNNER (Your Code)
-- By default, dap-python uses the local .venv if it finds one.
-- If you want to be absolutely certain, you can force the configuration 
-- to look for the .venv explicitly like this:
table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = 'My Custom Launch',
  program = '${file}',
  -- This logic looks for your local .venv python
  pythonPath = function()
    local cwd = vim.fn.getcwd()
    if vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
      return cwd .. '/.venv/bin/python'
    elseif vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
      return cwd .. '/venv/bin/python'
    else
      return '/usr/bin/python3' -- Fallback to system python
    end
  end,
})

-- Listeners and Keymaps
dap.listeners.after.event_initialized['dap_view_config'] = function() dapview.open() end
dap.listeners.before.event_terminated['dap_view_config'] = function() dapview.close() end
dap.listeners.before.event_exited['dap_view_config'] = function() dapview.close() end

-- 4. Keymaps
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Continue' })
vim.keymap.set('n', '<leader>si', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<leader>so', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<leader>sx', dap.terminate, { desc = 'Debug: Terminate' })
vim.keymap.set('n', '<leader>du', dapview.toggle, { desc = 'Debug: Toggle UI' })


