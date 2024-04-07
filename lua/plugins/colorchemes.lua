return {
    { -- monokai-pro package | https://github.com/loctvl842/monokai-pro.nvim
        "loctvl842/monokai-pro.nvim",
        lazy = false,
        name = "monokai-pro",
        priority = 1000,

        opts = {
            transparent_background = false,
            devicons = true,
            filter = "classic", -- classic | octagon | pro | machine | ristretto | spectrum
            day_night = {
                enable = false,
                day_filter = "classic",
                night_filter = "classic",
            },
            inc_search = "background", -- underline | background
            background_clear = {},
            plugins = {
                bufferline = {
                    underline_selected = true,
                    underline_visible = false,
                    underline_fill = true,
                    bold = false,
                },
            },
            indent_blankline = {
                context_highlight = "pro", -- default | pro
                context_start_underline = true,
            },
        },

        config = function()
            -- monokai-pro - Configuration
            vim.cmd.colorscheme("monokai-pro-classic")
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },
}
