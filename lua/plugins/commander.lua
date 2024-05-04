local function save()
	-- save the current buffer
	local status, err = pcall(function()
		vim.cmd(":w")
	end)
end

local last_line_limit = 0
local function select_line_limit()
	local current_limit = vim.api.nvim_get_option_value("colorcolumn", {})
	local show_limit = "error"
	if tonumber(current_limit) < 1 then
		show_limit = tostring(last_line_limit)
	else
		show_limit = current_limit
	end
	local new_limit = vim.fn.input("Set line limit (current: " .. show_limit .. "): ")
	-- manejar si se escapa del input
	if new_limit == nil or new_limit == "" then
		return
	end
	vim.api.nvim_command("set colorcolumn=" .. new_limit)
	last_line_limit = new_limit
end

local function toggle_line_limit()
	local current_limit = vim.api.nvim_get_option_value("colorcolumn", {})
	if tonumber(current_limit) > 0 then
		last_line_limit = current_limit
		vim.api.nvim_command("set colorcolumn=0")
	else
		vim.api.nvim_command("set colorcolumn=" .. last_line_limit)
	end
end

local function toggle_show_whitespace()
	vim.cmd([[
        set list!
    ]])
end

return {
	{ -- commander/command palette | https://github.com/FeiyouG/commander.nvim
		"FeiyouG/commander.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },

		keys = {
			{ "<leader>fc", "<cmd>Telescope commander<CR>", mode = "n", desc = "Open Commander" },
			-- custom keymaps
			{ "<leader>swt", toggle_show_whitespace, mode = "n", desc = "Toggle Show Whitespaces" },
			{ "<leader>lt", toggle_line_limit, mode = "n", desc = "Toggle Show Line Limit" },
			{ "<leader>ls", select_line_limit, mode = "n", desc = "Set New Line Limit" },
			{ "<C-s>", save, mode = "n", desc = "Save Current Buffer" },
		},

		config = function()
			require("commander").setup({
				integration = {
					telescope = {
						-- Set to true to use telescope instead of vim.ui.select for the UI
						enable = true,
						-- Can be any builtin or custom telescope theme
						theme = require("telescope.themes").commander,
					},
					lazy = {
						-- Set to true to automatically add all key bindings set through lazy.nvim
						enable = true,
						-- Set to true to use plugin name as category for each keybinding added from lazy.nvim
						set_plugin_name_as_cat = false,
					},
				},
			})
			-- Add a new command
			local commander = require("commander")
			commander.add({
				{
					desc = "Move to the Right Tab",
					cmd = "<cmd>BufferNext<CR>",
					keys = { "n", "<M-Right>" },
				},
				{
					desc = "Move to the Left Tab",
					cmd = "<cmd>BufferPrevious<CR>",
					keys = { "n", "<M-Left>" },
				},
				{
					desc = "Move Tab to the Right",
					cmd = "<cmd>BufferMoveNext<CR>",
					keys = { "n", "<M-S-Right>" },
				},
				{
					desc = "Move Tab to the Left",
					cmd = "<cmd>BufferMovePrevious<CR>",
					keys = { "n", "<M-S-Left>" },
				},
				{
					desc = "Close Tab Tab",
					cmd = "<cmd>BufferClose<CR>",
					keys = { "n", "<M-d>" },
				},
			})
		end,
	},
}
