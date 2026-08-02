return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'rcarriga/nvim-dap-ui',
      'mfussenegger/nvim-dap-python',
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      local dap_python = require 'dap-python'

      require('dapui').setup {}
      require('nvim-dap-virtual-text').setup {
        commented = true, -- Show virtual text alongside comment
      }

      dap_python.setup 'python3'

      vim.fn.sign_define('DapBreakpoint', {
        text = '',
        texthl = 'DiagnosticSignError',
        linehl = '',
        numhl = '',
      })

      vim.fn.sign_define('DapBreakpointRejected', {
        text = '', -- or "❌"
        texthl = 'DiagnosticSignError',
        linehl = '',
        numhl = '',
      })

      vim.fn.sign_define('DapStopped', {
        text = '', -- or "→"
        texthl = 'DiagnosticSignWarn',
        linehl = 'Visual',
        numhl = 'DiagnosticSignWarn',
      })

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end

      -- Toggle breakpoint
      vim.keymap.set('n', '<leader>Db', function()
        dap.toggle_breakpoint()
      end, { noremap = true, silent = true, desc = 'Toggle breakpoint' })

      -- Continue / Start
      vim.keymap.set('n', '<leader>Dc', function()
        dap.continue()
      end, { noremap = true, silent = true, desc = 'Continue' })

      -- Step Over
      vim.keymap.set('n', '<leader>Do', function()
        dap.step_over()
      end, { noremap = true, silent = true, desc = 'Step over' })

      -- Step Into
      vim.keymap.set('n', '<leader>Di', function()
        dap.step_into()
      end, { noremap = true, silent = true, desc = 'Step into' })

      -- Step Out
      vim.keymap.set('n', '<leader>DO', function()
        dap.step_out()
      end, { noremap = true, silent = true, desc = 'Step out' })

      -- Keymap to terminate debugging
      vim.keymap.set('n', '<leader>Dq', function()
        require('dap').terminate()
      end, { noremap = true, silent = true, desc = 'Terminate debugger' })

      -- Toggle DAP UI
      vim.keymap.set('n', '<leader>Du', function()
        dapui.toggle()
      end, { noremap = true, silent = true, desc = 'Toggle DAP UI' })
    end,
  },
}
