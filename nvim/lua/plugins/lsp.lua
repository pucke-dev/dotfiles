return {
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", opts = {} },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP.
            { "j-hui/fidget.nvim", opts = {} },

            -- Allows extra capabilities provided by blink.cmp
            "saghen/blink.cmp",
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or "n"
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end
                    -- Keymaps

                    -- Jump to the definition of the word under your cursor.
                    --  This is where a variable was first declared, or where a function is defined, etc.
                    --  To jump back, press <C-t>.
                    map("gd", "<cmd>lua Snacks.picker.lsp_definitions()<cr>", "[G]oto [D]efinition")

                    -- WARN: This is not Goto Definition, this is Goto Declaration.
                    --  For example, in C this would take you to the header.
                    map("gD", "<cmd>lua Snacks.picker.lsp_declarations()<cr>", "[G]oto [D]eclaration")

                    -- Find references for the word under your cursor.
                    map("gr", "<cmd>lua Snacks.picker.lsp_references()<cr>", "[G]oto [R]eferences")

                    -- Jump to the implementation of the word under your cursor.
                    --  Useful when your language has ways of declaring types without an actual implementation.
                    map("gI", "<cmd>lua Snacks.picker.lsp_implementations()<cr>", "[G]oto [I]mplementation")

                    -- Jump to the type of the word under your cursor.
                    --  Useful when you're not sure what type a variable is and you want to see
                    --  the definition of its *type*, not where it was *defined*.
                    map("gy", "<cmd>lua Snacks.picker.lsp_type_definitions()<cr>", "[G]oto [T]ype Definition")

                    -- Fuzzy find all the symbols in your current document.
                    --  Symbols are things like variables, functions, types, etc.
                    map("<leader>fs", "<cmd>lua Snacks.picker.lsp_symbols()<cr>", "[F]ind [S]ymbol")

                    -- Fuzzy find all the symbols in your current workspace.
                    --  Similar to document symbols, except searches over your entire project.
                    map("<leader>fS", "<cmd>lua Snacks.picker.lsp_workspace_symbols()<cr>", "[F]ind Workspace [S]ymbol")

                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                end,
            })

            -- Diagnostic Config
            -- See :help vim.diagnostic.Opts

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            local servers = {
                --                         nushell = {},
                tailwindcss = {},
                html = {},
                graphql = {},
                terraformls = {},
                protols = {},
                -- gopls = {
                --     usePlaceholders = true,
                --     staticcheck = true,
                --     gofumpt = true,
                --     hints = {
                --         assignVariableTypes = true,
                --         compositeLiteralFields = true,
                --         constantValues = true,
                --         functionTypeParameters = true,
                --         paramterNames = true,
                --         rangeVariableTypes = true,
                --     },
                -- },
                ts_ls = {},
                -- lua_ls = {},
            }

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, { "stylua" })

            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
            require("mason-lspconfig").setup({
                ensure_installed = {}, -- explicitly set to empty table
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },
}
