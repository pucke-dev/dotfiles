local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require "telescope.config".values

local delimiter = "  "

local live_grep = function(opts)
    opts = opts or {}
    opts.cwd = opts.cwd or vim.uv.cwd()

    local finder = finders.new_async_job {
        command_generator = function(prompt)
            if not prompt or prompt == "" then
                return nil
            end

            local parts = vim.split(prompt, delimiter)
            local args = { "rg" }

            if parts[1] then
                table.insert(args, "-e")
                table.insert(args, parts[1])
            end

            if parts[2] then
                table.insert(args, "-g")
                table.insert(args, parts[2])
            end

            return vim.iter({
                    args,
                    { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" }
                })
                :flatten(math.huge):totable()
        end,
        entry_maker = make_entry.gen_from_vimgrep(opts),
        cwd = opts.cwd,
    }

    pickers.new(opts, {
        debounce = 100,
        prompt_title = "Live Grep",
        finder = finder,
        previewer = conf.grep_previewer(opts),
        sorter = require("telescope.sorters").empty(),
    }):find()
end

return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            require("telescope").setup {
                pickers = {
                    find_files = { theme = "ivy" },
                },
                extensions = { fzf = {} }
            }

            require("telescope").load_extension("fzf")

            vim.keymap.set("n", "<space>fd", require("telescope.builtin").find_files)
            vim.keymap.set("n", "<space>fh", require("telescope.builtin").help_tags)
            vim.keymap.set("n", "<space>fg", live_grep)
            vim.keymap.set("n", "<space>ep", function()
                require("telescope.builtin").find_files {
                    cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
                }
            end)




            -- WARNING: The following does not include symlinks...
            -- vim.keymap.set("n", "<space>ed", function()
            -- require("telescope.builtin").find_files {
            -- cwd = "~/.config"
            -- }
            -- end)
        end
    },
}
