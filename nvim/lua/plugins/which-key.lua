return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            delay = 0,
            icons = {
                mappings = vim.g.have_nerd_font,
            },
        },
        spec = {
            { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
            { '<leader>f', group = '[F]ind' },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    }
}
