return {
    {
        'saghen/blink.cmp',
        event = 'VimEnter',
        version = '1.*',
        dependencies = {
            'folke/lazydev.nvim',
            'L3MON4D3/LuaSnip',
        },
        --- @module 'blink.cmp'
        --- @type blink.cmp.Config
        opts = {
            keymap = {
                preset = 'default',
            },
            appearance = {
                nerd_font_variant = 'mono',
                use_nvim_cmp_as_default = true,
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 100,
                },
            },
            snippets = {
                preset = 'luasnip',
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
                providers = {
                    lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
                },
            },
            fuzzy = { implementation = 'prefer_rust_with_warning' },
            signature = { enabled = true },
        },
    }
}
