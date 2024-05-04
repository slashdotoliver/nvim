return { -- treesitter package | https://github.com/nvim-treesitter/nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },

    config = function()
        -- treesitter
        local opts = {
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        }

        require("nvim-treesitter.configs").setup(opts)
    end,
}
