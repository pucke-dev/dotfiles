return {
    "L3MON4D3/LuaSnip",
    {
        "saghen/blink.cmp",
        event = "VimEnter",
        version = "*",
        dependencies = {
            "folke/lazydev.nvim",
            "rafamadriz/friendly-snippets",
        },
        --- @module 'blink.cmp'
        --- @type blink.cmp.Config
        opts = {
            snippets = { preset = "luasnip" },
            signature = { enabled = true },
            appearance = {
                nerd_font_variant = "mono",
                use_nvim_cmp_as_default = false,
            },
            keymap = {
                preset = "default",
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 100,
                },
            },
            sources = {
                default = { "lsp", "path", "snippets", "lazydev", "buffer" },
                providers = {
                    lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
                },
                per_filetype = {
                    codecompanion = { "codecompanion" },
                },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
    },
}
