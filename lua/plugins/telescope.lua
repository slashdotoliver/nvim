local builtin = require("telescope.builtin")

return {
	{ -- telescope package | https://github.com/nvim-telescope/telescope.nvim
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },

        keys = {
            { "<leader>ff", builtin.find_files, mode = "n", desc = "Find Files"},
            { "<leader>fg", builtin.live_grep, mode = "n", desc = "Find by Grep"},
            { "<leader>fb", builtin.buffers, mode = "n", desc = "Find Buffers"},
        },

		config = function()
			-- telescope
			require("telescope").setup({
				pickers = {
					find_files = {
						theme = "dropdown",
						border = true,
						borderchars = {
							prompt =  { "─", "│", " ", "│", "╭", "╮", "│", "│" },
							results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
							preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
						},
					},
				},
			})

			--local builtin = require("telescope.builtin")
			--vim.keymap.set("n", "<C-p>", builtin.find_files, {})
            --vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			--vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			--vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		end,
	},
	{ -- telescope code actions package | https://github.com/nvim-telescope/telescope-ui-select.nvim
		"nvim-telescope/telescope-ui-select.nvim",

		config = function()
            local telescope = require("telescope")
			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			telescope.load_extension("ui-select")
            telescope.load_extension("noice")
		end,
	},
}
