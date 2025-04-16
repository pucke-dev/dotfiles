return {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    config = function()
        require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })

        local ls = require("luasnip")
        local select_choice = require("luasnip.extras.select_choice")

        vim.keymap.set(
            { 'i', 's' },
            '<C-L>',
            function() ls.jump(1) end,
            { silent = true, desc = 'Luasnip: Jump forward' }
        )
        vim.keymap.set(
            { 'i', 's' },
            '<C-H>',
            function() ls.jump(-1) end,
            { silent = true, desc = 'Luasnip: Jump backward' }
        )
        vim.keymap.set(
            { 'i', 's' },
            '<C-E>',
            function() if ls.choice_active() then select_choice() end end,
            { silent = true, desc = 'Luasnip: Select choice' }
        )
    end,
}
