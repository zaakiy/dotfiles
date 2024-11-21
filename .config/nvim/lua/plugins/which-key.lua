-- which-key for key-mapping
if vim.g.vscode then    
  -- VSCode extension
else
  return
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        spec = {
          { "<leader>a", group = "Aerial", icon = "" }
        }
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
    }

end
