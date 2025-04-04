return {
    {
        'saghen/blink.cmp',
        event = 'VimEnter',
        version = '1.*',
        dependencies = {
            -- Snippet Engine
            -- todo
            'folke/lazydev.nvim',
            -- 'MeandeingProgrammer/render-markdown.nvim',
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
