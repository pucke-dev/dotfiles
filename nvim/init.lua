require("config.lazy")

vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 50

vim.keymap.set("n", "<space>ex", "<Cmd>:Explore<CR>", { desc = "[Ex]plore filesystem" })
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = "E[x]ecute lua code" })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "E[x]ecute lua code" })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
