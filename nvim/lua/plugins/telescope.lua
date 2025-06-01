return {
    {
        "nvim-telescope/telescope.nvim",
        event = 'VimEnter',
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function() return vim.fn.executable "make" == 1 end,
            },
            { "nvim-tree/nvim-web-devicons" },
        },
        config = function()
            require("telescope").setup {
                extensions = { fzf = {} }
            }

            require("telescope").load_extension("fzf")
        end
    },
}
