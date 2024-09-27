return {
    { -- https://github.com/lukas-reineke/virt-column.nvim
        -- :help virt-column.txt
        "lukas-reineke/virt-column.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            highlight = "Comment",
            char = "▕",
        },
    },
}
