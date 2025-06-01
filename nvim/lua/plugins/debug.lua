return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "leoluz/nvim-dap-go",
        "nvim-neotest/nvim-nio",
    },
    keys = function()
        local dap = require("dap")
        local dapui = require("dapui")

        return {
            {
                "<leader>dc",
                function()
                    dap.continue()
                end,
                desc = "[D]ebug: Start/[C]ontinue",
            },
            {
                "<leader>dsi",
                function()
                    dap.step_into()
                end,
                desc = "[D]ebug: [S]tep [I]nto",
            },
            {
                "<leader>dso",
                function()
                    dap.step_over()
                end,
                desc = "[D]ebug: [S]tep [O]ver",
            },
            {
                "<leader>dst",
                function()
                    dap.step_out()
                end,
                desc = "[D]ebug: [S]tep Ou[t]",
            },
            {
                "<leader>db",
                function()
                    dap.toggle_breakpoint()
                end,
                desc = "[D]ebug: Toggle [B]reakpoint",
            },
            {
                "<leader>dB",
                function()
                    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
                end,
                desc = "[D]ebug: Set [B]reakpoint",
            },
            {
                "<leader>dui",
                function()
                    dapui.toggle()
                end,
                desc = "[D]ebug: Toggle Debug [UI].",
            },
        }
    end,
    config = function()
        require("dap-go").setup({
            dap_configurations = {
                {
                    name = "Debug Package (Build Flags & Arguments)",
                    type = "go",
                    request = "launch",
                    program = "${fileDirname}",
                    build_flags = require("dap-go").get_build_flags,
                    args = require("dap-go").get_arguments,
                },
                {
                    type = "go",
                    name = "Attach remote",
                    mode = "remote",
                    request = "attach",
                },
            },
        })

        local dap = require("dap")
        local dapui = require("dapui")

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup({})

        dap.adapters.delve = {
            type = "server",
            host = "127.0.0.1",
            port = 38697,
        }
        dap.listeners.before.attach["dapui_config"] = dapui.open
        dap.listeners.before.launch["dapui_config"] = dapui.open
        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close
    end,
}
