local prompts = {
    -- Code related prompts
    Explain = "Please explain how the following code works.",
    Review = "Please review the following code and provide suggestions for improvement.",
    Tests = "Please explain how the selected code works, then generate unit tests for it.",
    Refactor = "Please refactor the following code to improve its clarity and readability.",
    FixCode = "Please fix the following code to make it work as intended.",
    FixError = "Please explain the error in the following text and provide a solution.",
    BetterNamings = "Please provide better names for the following variables and functions.",
    Documentation = "Please provide documentation for the following code.",
    SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
    SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",

    -- Text related prompts
    Summarize = "Please summarize the following text.",
    Spelling = "Please correct any grammar and spelling errors in the following text.",
    Wording = "Please improve the grammar and wording of the following text.",
    Concise = "Please rewrite the following text to make it more concise.",
}

return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        version = "v3.3.0",                      -- Use a specific version to prevent breaking changes
        dependencies = {
            { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
            { "nvim-lua/plenary.nvim" },
        },
        opts = {
            question_header = "  User ",
            answer_header = "  Copilot ",
            prompts = prompts,
            auto_follow_cursor = false,
            window = {
                width = 0.4,
            },
            mappings = {
                -- Use tab for completion
                complete = {
                    detail = "Use @<Tab> or /<Tab> for options.",
                    insert = "<Tab>",
                },
                -- Close the chat
                close = {
                    normal = "q",
                    insert = "<C-c>",
                },
                -- Reset the chat buffer
                reset = {
                    normal = "<C-x>",
                    insert = "<C-x>",
                },
                -- Submit the prompt to Copilot
                submit_prompt = {
                    normal = "<CR>",
                    insert = "<C-CR>",
                },
                -- Accept the diff
                accept_diff = {
                    normal = "<C-y>",
                    insert = "<C-y>",
                },
                -- Show help
                show_help = {
                    normal = "g?",
                },
            },
        },
        config = function(_, opts)
            local chat = require("CopilotChat")
            chat.setup(opts)
        end,
        event = "VeryLazy",
        keys = {
            -- Show prompts actions with telescope
            {
                "<leader>afp",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                end,
                desc = "CopilotChat - [F]ind [P]rompt Action",
            },

            -- Code related commands
            { "<leader>ae",  "<cmd>CopilotChatExplain<cr>",       desc = "CopilotChat - [E]xplain code" },
            { "<leader>agt", "<cmd>CopilotChatTests<cr>",         desc = "CopilotChat - [G]enerate [t]ests" },
            { "<leader>ar",  "<cmd>CopilotChatReview<cr>",        desc = "CopilotChat - [R]eview code" },
            { "<leader>aR",  "<cmd>CopilotChatRefactor<cr>",      desc = "CopilotChat - [R]efactor code" },
            { "<leader>abn", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - [B]etter [N]aming" },

            {
                "<leader>aqc",
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                    end
                end,
                desc = "CopilotChat - [Q]uick [C]hat",
            },

            { "<leader>am", "<cmd>CopilotChatCommit<cr>",        desc = "CopilotChat - Generate commit message for all changes", },
            { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>",     desc = "CopilotChat - Debug Info" },
            { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
            { "<leader>al", "<cmd>CopilotChatReset<cr>",         desc = "CopilotChat - Clear buffer and chat history" },

            { "<leader>av", "<cmd>CopilotChatToggle<cr>",        desc = "CopilotChat - Toggle" },
            { "<leader>av", ":CopilotChatVisual",                mode = "x",                                                     desc = "CopilotChat - Open in vertical split", },

            { "<leader>a?", "<cmd>CopilotChatModels<cr>",        desc = "CopilotChat - Select Models" },
            { "<leader>aa", "<cmd>CopilotChatAgents<cr>",        desc = "CopilotChat - Select Agents" },
        },
    },
}
