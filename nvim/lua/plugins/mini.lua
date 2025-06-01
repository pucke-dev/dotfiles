return {
    {
        "echasnovski/mini.nvim",
        config = function()
            local statusline = require "mini.statusline"
            statusline.setup { use_icons = vim.g.have_nerd_font }
            statusline.section_location = function()
                return '%2l:%-2v'
            end

            require "mini.ai".setup()
            require "mini.comment".setup()
            require "mini.operators".setup()
            require "mini.pairs".setup()
            require "mini.bracketed".setup()
            require "mini.surround".setup()

            -- Have to evaluate if that is needed
            -- Keymap: gS
            require "mini.splitjoin".setup()



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
