return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gts", ":Git<CR>", {})
      vim.keymap.set("n", "<leader>gtB", ":Git blame<CR>", {})
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "<leader>gtp", ":Gitsigns preview_hunk_inline<CR>", {})
      vim.keymap.set("n", "<leader>gtb", ":Gitsigns toggle_current_line_blame<CR>", {})
    end,
  },
}
