return {
    {
        "folke/trouble.nvim",
        opts = {
            modes = {
                workspace_diagnostics = {
                    mode = 'diagnostics',
                    filter = {
                        any = {
                            buf = 0, -- current buffer
                            {
                                function(item)
                                    return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
                                end,
                            }
                        },
                    },
                },
            },
        },
        cmd = "Trouble",
        keys = {
            {
                '<leader>xx',
                '<cmd>Trouble workspace_diagnostics toggle<cr>',
                desc = 'Workspace Diagnostics (Trouble)',
            },
            {
                '<leader>xX',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer Diagnostics (Trouble)',
            },
            -- IDK if this is useful
            -- {
            --     "<leader>sdri",
            --     "<cmd>Trouble lsp toggle focus=true win.position=right<cr>",
            --     desc = "[S]how LSP [D]efinitions / [R]eferences / [I]mplementations (Trouble)",
            -- },
        },
    }
}
