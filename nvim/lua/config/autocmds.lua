local api = vim.api

-- Highlight when yanking (copying) text
api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Enable spell checking for certain file types
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.txt", "*.md", "*.tex" },
    callback = function()
        vim.opt.spell = true
        vim.opt.spelllang = "en,de"
    end,
})

-- resize neovim split when terminal is resized
api.nvim_command("autocmd VimResized * wincmd =")
