return {
	{ -- cmp-nvim-lsp | https://github.com/hrsh7th/cmp-nvim-lsp
		-- Language servers provide different completion results depending on the capabilities of the client.
		-- Neovim's default omnifunc has basic support for serving completion candidates.
		-- nvim-cmp supports more types of completion candidates, so users must override the capabilities sent to
		-- the server such that it can provide these candidates during a completion request.
		-- These capabilities are provided via the helper function require('cmp_nvim_lsp').default_capabilities
		"hrsh7th/cmp-nvim-lsp",
	},
	{ -- LuaSnip | https://github.com/L3MON4D3/LuaSnip
		-- Snippet Engine for Neovim written in Lua.
		-- "injects the snippets for nvim-cmp"
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets", -- Snippets collection from different programming languages.
		},
	},
	{ -- nvim-cmp | https://github.com/hrsh7th/nvim-cmp
		-- A completion engine plugin for neovim written in Lua.
		-- Completion sources are installed from external repositories and "sourced".
		-- "creates the window for selecting completions."
		"hrsh7th/nvim-cmp",

		config = function()
			-- Set up nvim-cmp.
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load() -- Load LuaSnip snippets

			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
						-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<esc>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
					-- Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					-- { name = "vsnip" }, -- For vsnip users.
					{ name = "luasnip" }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = "buffer" },
				}),
			})

			cmp.setup.cmdline("/", {
				mappings = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})
		end,
	},
	{ -- commandline completions
		"hrsh7th/cmp-cmdline",
	},
	{ -- ?
		"hrsh7th/cmp-path",
	},
	{ -- ?
		"hrsh7th/cmp-buffer",
	},
}
