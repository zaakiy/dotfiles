return {
  -- Existing configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Define on_attach function for custom settings (optional)
      local on_attach = function(client, bufnr)
        -- Add buffer-specific key mappings or settings if needed.
      end

      -- Define capabilities to add capabilities for LSP (e.g., autocompletion)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      if cmp_nvim_lsp then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      -- Configure tsserver
      lspconfig.tsserver.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  }
}
