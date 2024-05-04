return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	event = { "BufReadPre", "BufNewFile" },

	--keys = {
	--    { "<M-Right>", "<cmd>BufferNext<CR>", mode = "n", desc = "Move Right Tab"},
	--    { "<M-Left>", "<cmd>BufferPrevious<CR>", mode = "n", desc = "Move Left Tab"},
	--    { "<M-S-Right>", "<cmd>BufferMoveNext<CR>", mode = "n", desc = "Move Tab to the Right"},
	--    { "<M-S-Left>", "<cmd>BufferMovePrevious<CR>", mode = "n", desc = "Move Tab to the Left"},
	--    { "<M-d>", "<cmd>BufferClose<CR>", mode = "n", desc = "Close Tab"},
	--},

	init = function()
		vim.g.barbar_auto_setup = false

		vim.keymap.set("n", "<M-Right>", "<cmd>BufferNext<CR>", { desc = "Move to the Right Tab" })
		vim.keymap.set("n", "<M-Left>", "<cmd>BufferPrevious<CR>", { desc = "Move to the Left Tab" })
		vim.keymap.set("n", "<M-S-Right>", "<cmd>BufferMoveNext<CR>", { desc = "Move Tab to the Right" })
		vim.keymap.set("n", "<M-S-Left>", "<cmd>BufferMovePrevious<CR>", { desc = "Move Tab to the Left" })
		vim.keymap.set("n", "<M-d>", "<cmd>BufferClose<CR>", { desc = "Close Tab" })
	end,
	opts = {
		-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
		animation = true,
		-- insert_at_start = true,
		-- …etc.
		clickable = true,
		sidebar_filetypes = {
			--["neo-tree"] = {
			--	event = "BufWipeout",
			--	--text = "neo-tree",
			--	--align = "center",
			--},
		},
		exclude_ft = {
			"neo-tree",
			"aplha",
		},
	},
	version = "^1.0.0", -- optional: only update when a new 1.x version is released
}
