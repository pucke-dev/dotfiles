return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            gitbrowse = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
        },
        keys = {
            { "<space>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
        },
    }
}
