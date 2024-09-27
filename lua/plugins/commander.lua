local function save()
    -- save the current buffer
    local status, err = pcall(function()
        vim.cmd(":w")
    end)
end

local last_line_limit = 0
local function select_line_limit()
    local current_limit = vim.api.nvim_get_option_value("colorcolumn", {})
    local show_limit = "error"
    if tonumber(current_limit) < 1 then
        show_limit = tostring(last_line_limit)
    else
        show_limit = current_limit
    end
    local new_limit = vim.fn.input("Set line limit (current: " .. show_limit .. "): ")
    -- manejar si se escapa del input
    if new_limit == nil or new_limit == "" then
        return
    end
    vim.api.nvim_command("set colorcolumn=" .. new_limit)
    last_line_limit = new_limit
end

local function toggle_line_limit()
    local current_limit = vim.api.nvim_get_option_value("colorcolumn", {})
    if tonumber(current_limit) > 0 then
        last_line_limit = current_limit
        vim.api.nvim_command("set colorcolumn=0")
    else
        vim.api.nvim_command("set colorcolumn=" .. last_line_limit)
    end
end

local function toggle_show_whitespace()
    vim.cmd([[
        set list!
    ]])
end

local function set_indentation()
    local indent = vim.fn.input("Change Indentation <1> Tabs | <2> Spaces: ")
    if indent == nil then
        return
    end

    local use_spaces = indent ~= "1"
    vim.bo.expandtab = use_spaces -- Usar espacios si no son tabulaciones
    if not use_spaces then
        local num_tabs = tonumber(vim.fn.input("Tab Size: "))
        if num_tabs == nil then
            return
        end
        vim.bo.tabstop = num_tabs -- Tamaño de tabulación
        vim.bo.shiftwidth = num_tabs -- Tamaño de la indentación
    else
        local num_spaces = tonumber(vim.fn.input("Number of Spaces: "))
        if num_spaces == nil then
            return
        end
        vim.bo.tabstop = num_spaces
        vim.bo.shiftwidth = num_spaces
    end
end

return {
    { -- commander/command palette | https://github.com/FeiyouG/commander.nvim
        "FeiyouG/commander.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },

        keys = {
            { "<leader>fc",  "<cmd>Telescope commander<CR>", mode = "n", desc = "Open Commander" },
            -- custom keymaps
            { "<leader>swt", toggle_show_whitespace,         mode = "n", desc = "Toggle Show Whitespaces" },
            { "<leader>slt", toggle_line_limit,              mode = "n", desc = "Toggle Show Line Limit" },
            { "<leader>sls", select_line_limit,              mode = "n", desc = "Set New Line Limit" },
            { "<C-s>",       save,                           mode = "n", desc = "Save Current Buffer" },
            { "<leader>si",  set_indentation,                mode = "n", desc = "Change Indentation" },
        },

        config = function()
            require("commander").setup({
                integration = {
                    telescope = {
                        -- Set to true to use telescope instead of vim.ui.select for the UI
                        enable = true,
                        -- Can be any builtin or custom telescope theme
                        theme = require("telescope.themes").commander,
                    },
                    lazy = {
                        -- Set to true to automatically add all key bindings set through lazy.nvim
                        enable = true,
                        -- Set to true to use plugin name as category for each keybinding added from lazy.nvim
                        set_plugin_name_as_cat = false,
                    },
                },
            })
        end,
    },
}
