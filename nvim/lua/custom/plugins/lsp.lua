return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Main LSP: Pyright
      require('lspconfig').basedpyright.setup {
        capabilities = capabilities,
      }

      -- Jedi for rename only
      require('lspconfig').jedi_language_server.setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Disable Jedi diagnostics so they don’t duplicate Pyright
          client.server_capabilities.diagnosticProvider = false
          client.server_capabilities.hoverProvider = false
          client.server_capabilities.completionProvider = false

          -- Only use Jedi for renaming
          vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, {
            buffer = bufnr,
            desc = 'Rename symbol (Jedi)',
          })
        end,
      }

      -- Global diagnostic config
      vim.diagnostic.config {
        virtual_text = { prefix = '●' },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      }
    end,
  },
}
