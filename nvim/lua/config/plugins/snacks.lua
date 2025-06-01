return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            words = { enabled = true },
            picker = { enabled = true },
            input = { enabled = true },
            gitbrowse = { enabled = true },
            indent = { enabled = true },
            notifier = { enabled = true },
        },
        keys = {
            {
                "<space>gB",
                function()
                    Snacks.gitbrowse()
                end,
                desc = "[G]it [B]rowse",
                mode = { "n", "v" },
            },

            { "<leader>fh", "<cmd>lua Snacks.picker.help()<cr>", "[F]ind [H]elp" },
            { "<leader>fk", "<cmd>lua Snacks.picker.keymaps()<cr>", "[F]ind [K]eymap" },

            { "<leader>ff", "<cmd>lua Snacks.picker.files()<cr>", "[F]ind [F]ile" },
            { "<leader>fw", "<cmd>lua Snacks.picker.grep_word()<cr>", "[F]ind current [W]ord" },
            { "<leader>fg", "<cmd>lua Snacks.picker.grep()<cr>", "[F]ind by [G]rep" },

            { "<leader>fr", "<cmd>lua Snacks.picker.resume()<cr>", "[F]ind [R]esume" },
            { "<leader><leader>", "<cmd>lua Snacks.picker.smart()<cr>", "Smart find files" },
            { "<leader>/", "<cmd>lua Snacks.picker.grep_buffers()<cr>", "[/] Fuzzy find in buffers" },

            {
                "<leader>sn",
                function()
                    Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
                end,
                "[S]earch [N]eovim files",
            },

            { "<leader>nh", "<cmd> lua Snacks.notifier.show_history()<cr>", "[N]otifier show [H]istory" },
        },
    },
}
