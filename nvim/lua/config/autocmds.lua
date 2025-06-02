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

-- Add lsp keymaps when an lsp server attaches to a buffer
api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map("gd", "<cmd>lua Snacks.picker.lsp_definitions()<cr>", "[G]oto [D]efinition")

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("gD", "<cmd>lua Snacks.picker.lsp_declarations()<cr>", "[G]oto [D]eclaration")

        -- Find references for the word under your cursor.
        map("gr", "<cmd>lua Snacks.picker.lsp_references()<cr>", "[G]oto [R]eferences")

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gI", "<cmd>lua Snacks.picker.lsp_implementations()<cr>", "[G]oto [I]mplementation")

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("gy", "<cmd>lua Snacks.picker.lsp_type_definitions()<cr>", "[G]oto [T]ype Definition")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map("<leader>fs", "<cmd>lua Snacks.picker.lsp_symbols()<cr>", "[F]ind [S]ymbol")

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map("<leader>fS", "<cmd>lua Snacks.picker.lsp_workspace_symbols()<cr>", "[F]ind Workspace [S]ymbol")

        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    end,
})
