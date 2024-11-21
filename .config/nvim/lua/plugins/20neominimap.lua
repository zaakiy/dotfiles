--- neominimap
return
  {
    "Isrothy/neominimap.nvim",
    version = "v3.*.*",
    enabled = true,
    lazy = false, -- NOTE: NO NEED to Lazy load
    -- Optional
    keys = {
      -- Global Minimap Controls
      { "<leader>nm", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
      { "<leader>no", "<cmd>Neominimap on<cr>", desc = "Enable global minimap" },
      { "<leader>nc", "<cmd>Neominimap off<cr>", desc = "Disable global minimap" },
      { "<leader>nr", "<cmd>Neominimap refresh<cr>", desc = "Refresh global minimap" },

      -- Window-Specific Minimap Controls
      { "<leader>nwt", "<cmd>Neominimap winToggle<cr>", desc = "Toggle minimap for current window" },
      { "<leader>nwr", "<cmd>Neominimap winRefresh<cr>", desc = "Refresh minimap for current window" },
      { "<leader>nwo", "<cmd>Neominimap winOn<cr>", desc = "Enable minimap for current window" },
      { "<leader>nwc", "<cmd>Neominimap winOff<cr>", desc = "Disable minimap for current window" },

      -- Tab-Specific Minimap Controls
      { "<leader>ntt", "<cmd>Neominimap tabToggle<cr>", desc = "Toggle minimap for current tab" },
      { "<leader>ntr", "<cmd>Neominimap tabRefresh<cr>", desc = "Refresh minimap for current tab" },
      { "<leader>nto", "<cmd>Neominimap tabOn<cr>", desc = "Enable minimap for current tab" },
      { "<leader>ntc", "<cmd>Neominimap tabOff<cr>", desc = "Disable minimap for current tab" },

      -- Buffer-Specific Minimap Controls
      { "<leader>nbt", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
      { "<leader>nbr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
      { "<leader>nbo", "<cmd>Neominimap bufOn<cr>", desc = "Enable minimap for current buffer" },
      { "<leader>nbc", "<cmd>Neominimap bufOff<cr>", desc = "Disable minimap for current buffer" },

      ---Focus Controls
      { "<leader>nf", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
      { "<leader>nu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
      { "<leader>ns", "<cmd>Neominimap toggleFocus<cr>", desc = "Switch focus on minimap" },
    },
    init = function()
      -- The following options are recommended when layout == "float"
      --vim.opt.wrap = false
      vim.opt.sidescrolloff = 36 -- Set a large value

      --- Put your configuration here
      ---@type Neominimap.UserConfig
      vim.g.neominimap = {
        --- Either `split` or `float`
        --- When layout is set to `float`,
        --- the minimap will be created in floating windows attached to all suitable windows
        --- When layout is set to `split`,
        --- the minimap will be created in one split window
        layout = "split", ---@type Neominimap.Config.LayoutType
        exclude_buftypes = {
            "nofile",
            "nowrite",
            "quickfix",
            "terminal",
            "prompt",
        },
        -- When false is returned, the minimap will not be created for this buffer
        ---@type fun(bufnr: integer): boolean
        buf_filter = function()
            return true
        end,
    
        -- When false is returned, the minimap will not be created for this window
        ---@type fun(winid: integer): boolean
        win_filter = function()
            return true
        end,
    
        -- How many columns a dot should span
        x_multiplier = 8, ---@type integer
    
        -- How many rows a dot should span
        y_multiplier = 2, ---@type integer
        --- Used when `layout` is set to `split`
        split = {
            minimap_width = 15, ---@type integer
    
            -- Always fix the width of the split window
            fix_width = true, ---@type boolean
    
            ---@alias Neominimap.Config.SplitDirection "left" | "right"
            direction = "right", ---@type Neominimap.Config.SplitDirection
    
            ---Automatically close the split window when it is the last window
            close_if_last_window = true, ---@type boolean
        },
        auto_enable = true,
        click = {
          -- Enable mouse click on minimap
          enabled = true, ---@type boolean
          -- Automatically switch focus to minimap when clicked
          auto_switch_focus = true, ---@type boolean
        },
          
      }
    end,
  }
