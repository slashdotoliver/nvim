return {
    { -- mason package | https://github.com/williamboman/mason.nvim
        "williamboman/mason.nvim",

        keys = {
            { "<C-q>",      vim.lsp.buf.hover,           mode = "n", desc = "Hover Info" },
            { "<leader>gd", vim.lsp.buf.definition,      mode = "n", desc = "Go to Definition" },
            --{ "<leader>gu", vim.lsp.buf.declaration, mode = "n", desc = "Go to Usages or Declarations" },
            { "<leader>gu", vim.lsp.buf.references,      mode = "n", desc = "Go to Usages or References" },
            { "<leader>gi", vim.lsp.buf.implementation,  mode = "n", desc = "Go to Implementation" },
            { "<leader>gt", vim.lsp.buf.type_definition, mode = "n", desc = "Go to Type Definition" },
            { "<M-Enter>",  vim.lsp.buf.code_action,     mode = "n", desc = "See Code Actions" },
            { "<leader>gf", vim.lsp.buf.format,          mode = "n", desc = "'Go' Format" },
            { "<F18>",      vim.lsp.buf.rename,          mode = "n", desc = "Rename Variable under Cursor" },
        },

        opts = {
            ensure_installed = {
                -- diagnostics
                --"ruff",
                --"mypy",
            },
            registries = {
                --"github:nvim-java/mason-registry",
                "github:mason-org/mason-registry",
            },
        },
    },
    { -- mason-lspconfig | https://github.com/williamboman/mason-lspconfig.nvim
        "williamboman/mason-lspconfig.nvim",

        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls", -- lua LSP
                    "clangd", -- c LSP, ...
                    "jedi_language_server", -- python LSP
                    "jdtls", -- java LSP, used by nvim-jdlts
                    "omnisharp", -- c# LSP, OmniSharp server based on Roslyn workspaces
                },
            })
        end,
    },
    { -- nvim-lspconfig | https://github.com/neovim/nvim-lspconfig
        "neovim/nvim-lspconfig",

        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            -- c-sharp omnisharp optional
            "Hoffs/omnisharp-extended-lsp.nvim",
        },

        config = function()
            -- capabilities for snippets for LSPs
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local cmp_lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp_capabilities)

            local lspconfig = require("lspconfig")

            -- TODO: add other things to their setups

            -- Setup for LSPs, include snippets capabilities
            lspconfig.lua_ls.setup({
                capabilities = capabilities, -- Include this in every LSP
                filetypes = { "lua" },
            })

            lspconfig.clangd.setup({
                capabilities = capabilities,
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
            })

            lspconfig.jedi_language_server.setup({
                capabilities = capabilities,
                filetypes = { "python" },
            })

            lspconfig.jdtls.setup({
                capabilities = capabilities,
                filetypes = { "java" },
                --root_dir = function() return vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]) end,
                --single_file_support = false,
            })

            lspconfig.gdscript.setup({
                capabilities = capabilities,
                filetypes = { "gd", "gdscript", "gdscript3" },
                on_attach = function()
                    local gdproject = io.open(vim.fn.getcwd() .. "/project.godot", "r")
                    if gdproject then
                        io.close(gdproject)
                        vim.fn.serverstart("./godothost")
                        print("Opened socket 'godothost' to communicate with godot.")
                    else
                        print("Unable to find 'project.godot', the gdscript LSP server cannot work.")
                    end
                end,
            })

            local dotnet_bin = vim.fn.expand("~/.dotnet/dotnet")
            local omnisharp_dll = vim.fn.expand("~/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll")
            local omnisharp_extended = require("omnisharp_extended")
            lspconfig.omnisharp.setup({ -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#omnisharp
                capabilities = capabilities,
                filetypes = { "cs", "vb" },
                cmd = { dotnet_bin, omnisharp_dll },
                settings = {
                    FormattingOptions = {
                        -- Enables support for reading code style, naming convention and analyzer settings from .editorconfig.
                        EnableEditorConfigSupport = true,
                    },
                    RoslynExtensionsOptions = {
                        -- Enables support for roslyn analyzers, code fixes and rulesets.
                        EnableAnalyzersSupport = true,
                        EnableImportCompletion = true,
                        AnalyzeOpenDocumentsOnly = false,
                    },
                    Sdk = {
                        IncludePrereleases = true,
                    },
                },
                handlers = {
                    ["textDocument/definition"] = omnisharp_extended.definition_handler,
                    ["textDocument/typeDefinition"] = omnisharp_extended.type_definition_handler,
                    ["textDocument/references"] = omnisharp_extended.references_handler,
                    ["textDocument/implementation"] = omnisharp_extended.implementation_handler,
                },
            })
        end,
    },
}
