return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('lspconfig').pyright.setup {
        capabilities = capabilities,
      }
    end,
  },

  vim.diagnostic.config {
    virtual_text = {
      prefix = '●', -- or "■" or "▶", pick what you like
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  },
}
