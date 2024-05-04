return { -- lualine package | https://github.com/nvim-lualine/lualine.nvim
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "chrisgrieser/nvim-recorder",
    },
    event = { "BufReadPre", "BufNewFile" },

    config = function()
        require("lualine").setup({
            options = {
                theme = "auto",
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { { "mode", separator = { right = "" } } },
                lualine_b = {
                    --{ "filename", path = 1 },
                    "branch",
                    "windows",
                    require("recorder").recordingStatus,
                },
                lualine_c = { "diff" },
                lualine_x = {
                    "diagnostics",
                    "encoding",
                    {
                        "fileformat",
                        symbols = {
                            unix = "LF", --"", -- e712
                            dos = "CRLF", --"", -- e70f
                            mac = "CR", -- "", -- e711
                        },
                    },
                    "filetype",
                },
                lualine_y = {
                    "progress",
                    require("recorder").displaySlots,
                },
                lualine_z = { "location" },
            },
        })

        vim.cmd([[
            highlight! link lualine_b_windows_active Pmenu
            highlight! link lualine_b_windows_inactive Comment
        ]])
    end,
}
