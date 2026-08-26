return {
  -- add monokai-pro colorscheme
  {
    "loctvl842/monokai-pro.nvim",
    opts = {
      filter = "classic",
      transparent_background = false,

      inc_search = "background",
      background_clear = {
        "toggleterm",
        "telescope",
        "renamer",
        "notify",
      },
    },
  },

  -- configure LazyVim to load monokai-pro
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monokai-pro-classic",
    },
  },
}
