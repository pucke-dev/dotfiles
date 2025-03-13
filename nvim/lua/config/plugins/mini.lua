return {
    {
        "echasnovski/mini.nvim",
        config = function()
            require "mini.statusline".setup { use_icons = true }

            require "mini.ai".setup()

            require "mini.comment".setup()

            require "mini.operators".setup()

            require "mini.pairs".setup()

            require "mini.splitjoin".setup()

            require "mini.surround".setup()

            require "mini.bracketed".setup()


            require "mini.hipatterns".setup({
                highlighters = {
                    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                    hack  = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
                    todo  = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
                    note  = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
                },
                hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
            })
        end
    }
}
