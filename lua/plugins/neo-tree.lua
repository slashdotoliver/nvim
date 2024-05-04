Neotree_states = {
	HIDDEN = 1,
	FILETREE = 2,
	GIT = 3,
	BUFFERS = 4,
	SYMBOLS = 5,
}

Neotree_state_actions = {
	[Neotree_states.HIDDEN] = {
		enter = function() end,
		exit = function() end,
	},
	[Neotree_states.FILETREE] = {
		enter = function()
			vim.cmd(":Neotree filesystem reveal left")
		end,
		exit = function()
			vim.cmd(":Neotree filesystem close")
		end,
	},
	[Neotree_states.GIT] = {
		enter = function()
			vim.cmd(":Neotree git_status reveal left")
		end,
		exit = function()
			vim.cmd(":Neotree git_status close")
		end,
	},
	[Neotree_states.BUFFERS] = {
		enter = function()
			vim.cmd(":Neotree buffers reveal left")
		end,
		exit = function()
			vim.cmd(":Neotree buffers close")
		end,
	},
	[Neotree_states.SYMBOLS] = {
		enter = function()
			vim.cmd(":Neotree document_symbols reveal left")
		end,
		exit = function()
			vim.cmd(":Neotree document_symbols close")
		end,
	},
}

Current_state = Neotree_states.HIDDEN

function Neotree_change_state(new_state)
	local change_state = new_state
	if new_state == Current_state then
		change_state = Neotree_states.HIDDEN
	end

	Neotree_state_actions[Current_state].exit()
	vim.cmd(":BarbarEnable")
	Neotree_state_actions[change_state].enter()
	Current_state = change_state
end

return { -- neo-tree package | https://github.com/nvim-neo-tree/neo-tree.nvim
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	keys = {
		{ "<A-1>", ":lua Neotree_change_state(2)<CR>", mode = "n", desc = "Toggle Filetree Sidebar", silent = true },
		{ "<A-2>", ":lua Neotree_change_state(3)<CR>", mode = "n", desc = "Toggle Git Status Sidebar", silent = true },
		{ "<A-3>", ":lua Neotree_change_state(4)<CR>", mode = "n", desc = "Toggle Buffers Sidebar", silent = true },
		{ "<A-4>", ":lua Neotree_change_state(5)<CR>", mode = "n", desc = "Toggle Symbols Sidebar", silent = true },
	},

	config = function()
		-- if a colorscheme supports nvim-tree but not neo-tree some of the highlights
		-- can be linked with the following:
		vim.cmd([[
            highlight! link NeoTreeDirectoryIcon NvimTreeFolderIcon
            highlight! link NeoTreeDirectoryName NvimTreeFolderName
            highlight! link NeoTreeSymbolicLinkTarget NvimTreeSymlink
            highlight! link NeoTreeRootName NvimTreeRootFolder
            highlight! link NeoTreeDirectoryName NvimTreeOpenedFolderName
            highlight! link NeoTreeFileNameOpened NvimTreeOpenedFile

            highlight! link NeoTreeWinSeparator Comment
            highlight! link NeoTreeEndOfBuffer EndOfBuffer
            highlight! link NeoTreeNormalNC Normal
            highlight! link NeoTreeNormal Normal
        ]])

		require("neo-tree").setup({
			sources = {
				"filesystem",
				"git_status",
				"document_symbols",
				"buffers",
			},
			source_selector = {
				winbar = true,
				statusline = false,

				sources = {
					{ source = "filesystem" },
					{ source = "git_status" },
					{ source = "buffers" },
					{ source = "document_symbols" },
				},
			},
			document_symbols = {
				follow_cursor = true,
			},
		})
	end,
}
