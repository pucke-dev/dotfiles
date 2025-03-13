local load_lsp = function(name, opts, capabilities)
    opts = opts or {}
    opts.capabilities = capabilities

    require("lspconfig")[name].setup(opts)
end

local lsps = {
    lua_ls = {},
    ts_ls = {},
    tailwindcss = {},
    html = {},
    graphql = {},
    --    golangci_lint_ls = {},
    gopls = {
        settings = {
            gopls = {
                usePlaceholders = true,
                staticcheck = true,
                gofumpt = true,
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    paramterNames = true,
                    rangeVariableTypes = true,
                },
            },
        },
    },
    terraformls = {},
    phpactor = {
        init_options = {
            ["language_server_phpstan.enabled"] = true,
            ["language_server_psalm.enabled"] = false,
        },
    },
    protols = {},
}

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            for lsp, opts in pairs(lsps) do
                load_lsp(lsp, opts, capabilities)
            end

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
            vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "[G]oto [R]eferences" })
            vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
            vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto T[y]pe Definition" })
            vim.keymap.set("n", "gic", vim.lsp.buf.incoming_calls, { desc = "[G]oto [I]ncoming [C]alls" })
            vim.keymap.set("n", "goc", vim.lsp.buf.outgoing_calls, { desc = "[G]oto [O]utgoing [C]alls" })
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
            vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[R]ename" })


            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    if not client then return end

                    if client:supports_method('textDocument/formatting') then
                        -- Format the current buffer on save
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                            end,
                        })
                    end
                end,
            })

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.tf", "*.tfvars" },
                callback = function() vim.lsp.buf.format() end
            })

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    local params = vim.lsp.util.make_range_params(0, "utf-8")
                    params.context = { only = { "source.organizeImports" } }
                    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
                    -- machine and codebase, you may want longer. Add an additional
                    -- argument after params if you find that you have to write the file
                    -- twice for changes to be saved.
                    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
                    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
                    for cid, res in pairs(result or {}) do
                        for _, r in pairs(res.result or {}) do
                            if r.edit then
                                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                                vim.lsp.util.apply_workspace_edit(r.edit, enc)
                            end
                        end
                    end
                    vim.lsp.buf.format({ async = false })
                end
            })
        end
    },
}
