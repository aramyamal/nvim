local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key


ls.setup({
    enable_autosnippets = true,
})

require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets" })
require("luasnip.loaders.from_vscode").load({ paths = vim.fn.stdpath("config") .. "/snippets" })
require("luasnip.loaders.from_vscode").lazy_load()

-- for "all" filetypes create snippet for "func"
-- ls.add_snippets("all", {
--     ls.parser.parse_snippet(
--         'func',
--         'function ${1}(${2}) \n{\n\t${3}\n}'),
-- })
--
-- -- Map "Ctrl + tab" (in insert mode)
-- to expand snippet and jump through fields to overwrite if cmp asks for autocomplete.
vim.keymap.set(
    'i',
    '<C-k>',
    function()
        if ls.expand_or_jumpable() then
            ls.expand_or_jump()
        end
    end,
    { desc = "LuaSnip: Jump to next placeholder or expand snippet" }
)

-- Jump backwards in snippet placeholders
vim.keymap.set('i', '<C-j>', function()
    if require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
    end
end, { desc = "LuaSnip: Jump to previous placeholder" })
