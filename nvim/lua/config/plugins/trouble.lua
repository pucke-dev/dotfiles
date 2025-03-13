return {
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>sD",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "[S]how [D]iagnostics (Trouble)",
            },
            {
                "<leader>sd",
                "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
                desc = "[S]how Buffer [D]iagnostics (Trouble)",
            },
            {
                "<leader>ss",
                "<cmd>Trouble symbols toggle focus=true<cr>",
                desc = "[S]how [S]ymbols in buffer. Nice to get an overview of the file structure.",
            },
            {
                "<leader>sdri",
                "<cmd>Trouble lsp toggle focus=true win.position=right<cr>",
                desc = "[S]how LSP [D]efinitions / [R]eferences / [I]mplementations (Trouble)",
            },
        },
    }
}
