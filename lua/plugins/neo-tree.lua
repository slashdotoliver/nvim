Neotree_states = {
    HIDDEN = 1,
    FILETREE = 2,
    GIT = 3,
    BUFFERS = 4,
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
}

Current_state = Neotree_states.HIDDEN

function Neotree_change_state(new_state)
    local change_state = new_state
    if new_state == Current_state then
        change_state = Neotree_states.HIDDEN
    end

    Neotree_state_actions[Current_state].exit()
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
    sources = {
        "document_symbols", -- FIXME
    },

    keys = {
		{ "<A-1>", ":lua Neotree_change_state(2)<CR>", mode = "n", desc = "Toggle Filetree Sidebar", silent = true },
        { "<A-2>", ":lua Neotree_change_state(3)<CR>", mode = "n", desc = "Toggle Git Status Sidebar", silent = true },
        { "<A-3>", ":lua Neotree_change_state(4)<CR>", mode = "n", desc = "Toggle Buffers Sidebar", silent = true },
	},

    config = function()
        -- neo-tree
        --vim.keymap.set("n", "<A-1>", ":lua Neotree_change_state(2)<CR>", { silent = true })
        --vim.keymap.set("n", "<A-2>", ":lua Neotree_change_state(3)<CR>", { silent = true })
        --vim.keymap.set("n", "<A-3>", ":lua Neotree_change_state(4)<CR>", { silent = true })

        -- if a colorscheme supports nvim-tree but not neo-tree some of the highlights
        -- can be linked with the following:
        vim.cmd([[
            highlight! link NeoTreeDirectoryIcon NvimTreeFolderIcon
            highlight! link NeoTreeDirectoryName NvimTreeFolderName
            highlight! link NeoTreeSymbolicLinkTarget NvimTreeSymlink
            highlight! link NeoTreeRootName NvimTreeRootFolder
            highlight! link NeoTreeDirectoryName NvimTreeOpenedFolderName
            highlight! link NeoTreeFileNameOpened NvimTreeOpenedFile
        ]])
    end,
}
