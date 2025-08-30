return {
  { -- Linting for Python files using pylint
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require 'lint'

      -- Configure linters by filetype
      lint.linters_by_ft = {
        python = { 'pylint' },
      }

      -- Run lint automatically on save
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        pattern = '*.py',
        callback = function()
          lint.try_lint()
        end,
      })

      -- Optional: keymap to run lint manually
      vim.keymap.set('n', '<leader>l', function()
        lint.try_lint()
      end, { desc = 'Run Py[l]int' })
    end,
  },
}
