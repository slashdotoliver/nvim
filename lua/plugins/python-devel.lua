do return {} end
local disabled = {
	{ -- swenv.nvim | https://github.com/AckslD/swenv.nvim
		-- Tiny plugin to quickly switch python virtual environments from within neovim without restarting.
		"AckslD/swenv.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("swenv").setup({
				-- Should return a list of tables with a `name` and a `path` entry each.
				-- Gets the argument `venvs_path` set below.
				-- By default just lists the entries in `venvs_path`.
				get_venvs = function(venvs_path)
					return require("swenv.api").get_venvs(venvs_path)
				end,
				-- Path passed to `get_venvs`.
				venvs_path = vim.fn.expand("~/Documents/PycharmProjects/"),
				-- Something to do after setting an environment, for example call vim.cmd.LspRestart
				post_set_venv = function() vim.cmd(":LspRestart") end,
			})
		end,

		keys = {
			--{ "<leader>lpv>", require("swenv.api").pick_venv, mode = "n", desc = "Select a Python Environment" },
		},
	},
}
