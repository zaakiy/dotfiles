return {
  "isakbm/gitgraph.nvim",
  dependencies = { "sindrets/diffview.nvim" },
  ---@type I.GGConfig
  opts = {
    symbols = {
      merge_commit = "",
      commit = "",
      merge_commit_end = "",
      commit_end = "",

      -- Advanced symbols
      GVER = "",
      GHOR = "",
      GCLD = "",
      GCRD = "╭",
      GCLU = "",
      GCRU = "",
      GLRU = "",
      GLRD = "",
      GLUD = "",
      GRUD = "",
      GFORKU = "",
      GFORKD = "",
      GRUDCD = "",
      GRUDCU = "",
      GLUDCD = "",
      GLUDCU = "",
      GLRDCL = "",
      GLRDCR = "",
      GLRUCL = "",
      GLRUCR = "",
    },
    format = {
      --timestamp = '%H:%M %d-%m-%Y',
      timestamp = "  %H:%M     %b %d   󰸘 %Y     %A      ",
      fields = { "branch_name", "hash", "timestamp", "author", "tag" },
    },
    hooks = {
      -- Check diff of a commit
      on_select_commit = function(commit)
        vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
        vim.notify("DiffviewOpen " .. commit.hash .. "^!")
      end,
      -- Check diff from commit a -> commit b
      on_select_range_commit = function(from, to)
        vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
        vim.notify("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
      end,
    },
  },
  keys = {
    {
      "<leader>gl",
      function()
        require("gitgraph").draw({}, { all = true, max_count = 5000 })
      end,
      desc = "GitGraph - Draw",
    },
  },
}
