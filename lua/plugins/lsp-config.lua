return {
	{ -- mason package | https://github.com/williamboman/mason.nvim
		"williamboman/mason.nvim",

		keys = {
			{ "<C-q>", vim.lsp.buf.hover, mode = "n", desc = "Hover Info" },
			{ "<leader>gd", vim.lsp.buf.definition, mode = "n", desc = "Go to Definition" },
			{ "<leader>gi", vim.lsp.buf.implementation, mode = "n", desc = "Go to Implementation" },
			{ "<M-Enter>", vim.lsp.buf.code_action, mode = "n", desc = "See Code Actions" },
			{ "<leader>gf", vim.lsp.buf.format, mode = "n", desc = "'Go' Format" },
		},

		config = function()
			require("mason").setup()
		end,
	},
	{ -- mason-lspconfig | https://github.com/williamboman/mason-lspconfig.nvim
		"williamboman/mason-lspconfig.nvim",

		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls", -- lua language server
					"clangd", -- c language server/
				},
			})
		end,
	},
	{ -- nvim-lspconfig | https://github.com/neovim/nvim-lspconfig
		"neovim/nvim-lspconfig",

		config = function()
			-- capabilities for snippets for LSPs
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

			-- Setup for LSPs, include snippets capabilities
			lspconfig.lua_ls.setup({
				capabilities = capabilities, -- Include this in every LSP
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
		end,
	},
}
