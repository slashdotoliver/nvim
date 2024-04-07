return {
    "nvimtools/none-ls.nvim",

    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = { -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
                null_ls.builtins.formatting.stylua,
            }
        })
    end
}
