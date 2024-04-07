return {
    { -- commander/command palette | https://github.com/FeiyouG/commander.nvim
        "FeiyouG/commander.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },

        keys = {
            { "<leader>fc", "<cmd>Telescope commander<CR>", mode = "n", desc = "Open Commander" },
            { "<C-p>",      "<cmd>Telescope commander<CR>", mode = "n", desc = "Open Commander" },
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
            })
            commander.add({
                {
                    desc = "Move to the Left Tab",
                    cmd = "<cmd>BufferPrevious<CR>",
                    keys = { "n", "<M-Left>" },
                },
            })
            commander.add({
                {
                    desc = "Move Tab to the Right",
                    cmd = "<cmd>BufferMoveNext<CR>",
                    keys = { "n", "<M-S-Right>" },
                },
            })
            commander.add({
                {
                    desc = "Move Tab to the Left",
                    cmd = "<cmd>BufferMovePrevious<CR>",
                    keys = { "n", "<M-S-Left>" },
                },
            })
            commander.add({
                {
                    desc = "Close Tab Tab",
                    cmd = "<cmd>BufferClose<CR>",
                    keys = { "n", "<M-d>" },
                },
            })
        end,
    },
}
