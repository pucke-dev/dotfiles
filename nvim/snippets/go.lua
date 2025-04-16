local ls = require "luasnip"
local f = ls.function_node
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local sn = ls.snippet_node

local fmta = require "luasnip.extras.fmt".fmta

local ts_locals = require "nvim-treesitter.locals"
local ts_utils = require "nvim-treesitter.ts_utils"

local get_node_text = vim.treesitter.get_node_text

vim.treesitter.query.set(
    "go",
    "LuaSnip_Result",
    [[ [
    (method_declaration result: (_) @id)
    (function_declaration result: (_) @id)
    (func_literal result: (_) @id)
  ] ]]
)


local transform = function(text, info)
    if text == "int" or text == 'int64' then
        return t "0"
    elseif text == "error" then
        if info then
            info.index = info.index + 1

            return t(info.err_name)
            -- return c(info.index, {
            -- t(info.err_name),
            -- t(string.format('fmt.Errorf("%s: %%v", %s)', info.func_name, info.err_name)),
            -- Be cautious with wrapping, it makes the error part of the API of the
            -- function, see https://go.dev/blog/go1.13-errors#whether-to-wrap
            -- t(string.format('fmt.Errorf("%s: %%w", %s)', info.func_name, info.err_name)),
            -- Old style (pre 1.13, see https://go.dev/blog/go1.13-errors), using
            -- https://github.com/pkg/errors
            -- t(string.format('errors.Wrap(%s, "%s")', info.err_name, info.func_name)),
            -- })
        else
            return t "err"
        end
    elseif text == "bool" then
        return t "false"
    elseif text == "string" then
        return t '""'
    elseif string.find(text, "*", 1, true) then
        return t "nil"
    end

    return t(text)
end

local handlers = {
    ["parameter_list"] = function(node, info)
        local result = {}

        local count = node:named_child_count()
        for idx = 0, count - 1 do
            table.insert(result, transform(get_node_text(node:named_child(idx), 0), info))
            if idx ~= count - 1 then
                table.insert(result, t { ", " })
            end
        end

        return result
    end,

    ["type_identifier"] = function(node, info)
        local text = get_node_text(node, 0)
        return { transform(text, info) }
    end,
}

local go_result_type = function(info)
    local cursor_node = ts_utils.get_node_at_cursor()
    if not cursor_node then
        vim.notify("No node found at cursor", vim.log.levels.WARN)
        return t "nil"
    end

    local scope = ts_locals.get_scope_tree(cursor_node, 0)

    local function_node
    for _, v in ipairs(scope) do
        if v:type() == "function_declaration" or v:type() == "method_declaration" or v:type() == "func_literal" then
            function_node = v
            break
        end
    end

    if not function_node then
        vim.notify("Not in a function", vim.log.levels.WARN)
        return t "nil"
    end

    local query = vim.treesitter.query.get("go", "LuaSnip_Result")
    for _, node in query:iter_captures(function_node, 0) do
        if handlers[node:type()] then
            return handlers[node:type()](node, info)
        end
    end

    return t "nil"
end

--- @param args table
local go_return_values = function(args)
    return sn(
        nil,
        go_result_type {
            index = 0,
            err_name = args[1][1],
        }
    )
end

vim.treesitter.query.set(
    "go",
    "LuaSnip_PossibleReceiver",
    [[ [
    (type_spec name: (_) @name type: (struct_type))
    (type_spec name: (_) @name type: (function_type))
    ] ]]
)

local go_receiver_values = function()
    local cursor_node = ts_utils.get_node_at_cursor()
    if not cursor_node then
        vim.notify("No node found at cursor", vim.log.levels.WARN)
        return sn(nil, t "nil")
    end

    local query = vim.treesitter.query.get("go", "LuaSnip_PossibleReceiver")

    local options = {}
    for _, node in query:iter_captures(cursor_node, 0) do
        if node:type() == 'type_identifier' then
            local receiver = get_node_text(node, 0)
            local short_name = string.lower(string.sub(receiver, 1, 1))

            table.insert(options, t(string.format("%s %s", short_name, receiver)))
            table.insert(options, t(string.format("%s *%s", short_name, receiver)))
        end
    end

    return sn(nil, c(1, options))
end

return {
    s('method', fmta(
        [[
        func (<receiver>) <name>(<args>) <result> {
            <body>
        }
        ]],
        {
            receiver = d(1, go_receiver_values),
            name = i(2, { "name" }),
            args = i(3),
            result = i(4),
            body = i(0),
        }
    )),
    s('ife', fmta(
        [[
        if <err> != nil {
            <r>
        }
        <>
    ]],
        {
            err = i(1, { "err" }),
            r = i(2),
            i(0),
        }
    )),
    s('ifern', fmta(
        [[
        if <err> != nil {
            return <result>
        }
        <>
    ]],
        {
            err = i(1, { "err" }),
            result = d(2, go_return_values, { 1 }),
            i(0),
        }
    )),
}
