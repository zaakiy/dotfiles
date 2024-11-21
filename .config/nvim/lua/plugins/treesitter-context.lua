return {
  -- other plugins
  "nvim-treesitter/nvim-treesitter-context",
  config = function()
    require("treesitter-context").setup({
      enable = true, -- Enable this plugin
      throttle = true, -- Throttle for large files
      max_lines = 0, -- No limit on lines
      patterns = { -- Match functions, classes, etc.
        default = {
          "class",
          "function",
          "method",
          "for",
          "while",
          "if",
          "switch",
          "case",
        },
      },
    })
  end,
}
