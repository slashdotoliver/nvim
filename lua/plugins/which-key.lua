return { -- which key popup display | https://github.com/folke/which-key.nvim
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        local wk = require("which-key")
        wk.register({
            ["<leader>"] = { name = "User Options" },
            ["<leader>f"] = { name = "Find / Open" },
            ["<leader>g"] = { name = "Go / Do " },
            ["<leader>r"] = { name = "Remove" },
            ["<leader>n"] = { name = "Notifications" },
            ["<leader>s"] = {
                name = "Settings",
                l = { name = "Line Limit / Ruler" },
                w = { name = "Whitespaces" },
            },
            ["<leader>q"] = { name = "Macros" },
            ["<leader>d"] = {
                name = "Debugging",
                p = { name = "Python" },
            },
        })
    end,
}
