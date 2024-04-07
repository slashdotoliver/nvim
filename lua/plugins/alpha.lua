return { -- alpha.nvim dashboard | https://github.com/goolord/alpha-nvim
    "goolord/alpha-nvim",

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
             [[                               __                ]],
             [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
             [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
             [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
             [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
             [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
         }

        -- dashboard config here
        dashboard.section.buttons.val = {
            dashboard.button("e", "  New File", ":ene <CR>"),
            dashboard.button("CTRL p", "  Open Commandline"),
            dashboard.button("SPC f c", "󱥚  Open Commander"),
            dashboard.button("SPC f f", "󰈞  Find File"),
            dashboard.button("SPC f h", "󰊄  Recently Opened Files (WIP)"),
            dashboard.button("SPC f r", "  Frecency/MRU (WIP)"),
            dashboard.button("SPC f g", "󰈬  Find Word"),
            dashboard.button("SPC f m", "  Jump to Bookmarks (WIP)"),
            dashboard.button("SPC f s", "  Find Session"),
            dashboard.button("SPC d s", "  Remove Session"),
            dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
        }

        alpha.setup(dashboard.opts)
    end,
}
