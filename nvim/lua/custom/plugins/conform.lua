return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        php = { 'pint' },
        json = { 'fixjson' },
        -- Ruff handles the entire formatting pipeline for Python
        python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
      },
    },
  },
}
