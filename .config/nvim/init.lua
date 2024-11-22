require("config.lazy")

vim.cmd("set clipboard+=unnamedplus")
vim.keymap.set("n", "<leader>rn", ":IncRename ")

-- Scrollbar color
vim.api.nvim_set_hl(0, "ScrollView", { bg = "#585ca8" })

-- ############# mini-ai: select Around/Inside text
require("mini.ai").setup()

-- ############# CCC colorpicker: Create Color Code
vim.opt.termguicolors = true
local ccc = require("ccc")
local mapping = ccc.mapping
ccc.setup({
	-- Your preferred settings
	-- Example: enable highlighter
	highlighter = {
		auto_enable = true,
		lsp = true,
	},
})

vim.keymap.set("n", "<C-c>", "<cmd>CccPick<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-c>", "<cmd>CccPick<CR>", { noremap = true, silent = true })

-- ############# GitGraph format
vim.api.nvim_set_hl(0, "GitGraphTimestamp", { fg = "#1a9999" })
vim.api.nvim_set_hl(0, "GitGraphBranchMsg", { italic = true, fg = "#e6e6e6" })

vim.api.nvim_set_hl(0, "GitGraphBranchTag", { fg = "#e63333" })
vim.api.nvim_set_hl(0, "GitGraphBranchName", { bold = true, fg = "#33b333" })
vim.api.nvim_set_hl(0, "GitGraphAuthor", { fg = "#336666" })
vim.api.nvim_set_hl(0, "GitGraphHash", { fg = "#663333" })

local function set_highlight_with_hex_and_format(group, hex_color, bold, italic, underline)
	-- Replace spaces or other delimiters with underscores in group names
	local sanitized_group = group:gsub("%s+", "_")

	-- Prepare highlight properties
	local properties = { fg = hex_color }
	properties.bold = bold or nil
	properties.italic = italic or nil
	properties.underline = underline or nil

	-- Set the highlight group with sanitized name and properties
	vim.api.nvim_set_hl(0, sanitized_group, properties)
end

local function set_highlights_by_keyword(keyword, hex_color, bold, italic, underline)
	-- Search for highlight groups matching the keyword and apply properties
	local highlights = vim.fn.getcompletion(keyword, "highlight")
	for _, highlight in ipairs(highlights) do
		set_highlight_with_hex_and_format(highlight, hex_color, bold, italic, underline)
	end
end

-- Set highlights for specific keywords
set_highlights_by_keyword("function", "#c9d996", false, false) -- Function highlights
set_highlights_by_keyword("variable", "#9cdcfe", false, false) -- Variable highlights
set_highlights_by_keyword("property", "#ad99f5", false, true) -- Property highlights with italic
set_highlights_by_keyword("string", "#ce9178", false, false) -- String highlights
set_highlights_by_keyword("boolean", "#569cd6", false, true) -- Boolean highlights with italic

-- ############# Aerial (Code outlie window)
require("aerial").setup({
	layout = {
		max_width = { 25, 0.2 },
		width = nil,
		min_width = 10,
	},
	-- optionally use on_attach to set keymaps when aerial has attached to a buffer
	on_attach = function(bufnr)
		-- Jump forwards/backwards with '{' and '}'
		vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
		vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
		vim.keymap.set("n", "<leader>a{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
		vim.keymap.set("n", "<leader>a}", "<cmd>AerialNext<CR>", { buffer = bufnr })
	end,
	autojump = false,
	open_automatic = true,
	default_direction = "prefer_right",

	resize_to_content = true,
	preserve_equality = false,
	lazy_load = false,
	disable_max_lines = 10000,
	disable_max_size = 2000000, -- Default 2MB
	filter_kind = {
		"Class",
		"Constructor",
		"Enum",
		"Function",
		"Interface",
		"Module",
		"Method",
		"Struct",
	},

	-- Determines where the aerial window will be opened
	--   edge   - open aerial at the far right/left of the editor
	--   window - open aerial to the right/left of the current window
	placement = "window",
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>aa", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial" })
vim.keymap.set("n", "<leader>as", "<cmd>Telescope aerial<CR>", { desc = "Symbol Search" })

-- Override highlights for added and removed text in Diffview
--vim.cmd([[
--  highlight DiffAdd guifg=NONE guibg=#005500
--  highlight DiffDelete guifg=NONE guibg=#550000
--  highlight DiffChange guifg=NONE guibg=NONE
--  highlight DiffText guifg=NONE guibg=#004400
--]])

-- Override highlights for inline text changes
--vim.api.nvim_set_hl(0, "DiffviewDiffAddAsDelete", { fg = "NONE", bg = "#550000", bold = false })
--vim.api.nvim_set_hl(0, "DiffviewDiffDelete", { fg = "NONE", bg = "#550000", bold = false })
--vim.api.nvim_set_hl(0, "DiffviewDiffAdd", { fg = "NONE", bg = "#007700", bold = false })
