return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = false,
      automatic_installation = false,
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              telemetry = { enable = false },
              workspace = { checkThirdParty = false },
            },
          },
        },
      },
    },
  },
}
