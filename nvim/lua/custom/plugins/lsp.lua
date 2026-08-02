return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local lspconfig = require 'lspconfig'
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local on_attach_disable_format = function(client, bufnr)
        -- We disable LSP formatting because we want Conform to handle it
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end

      -- =====================
      -- Python: Pyright
      -- =====================
      lspconfig.pyright.setup {
        capabilities = capabilities,
        on_attach = on_attach_disable_format,
      }

      -- =====================
      -- Diagnostics (global)
      -- =====================
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
