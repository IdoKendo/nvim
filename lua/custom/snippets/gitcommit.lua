require("luasnip.session.snippet_collection").clear_snippets("gitcommit")

local luasnip = require("luasnip")

local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

luasnip.add_snippets("gitcommit", {
    s("conventional commit", { i(1, "type"), t(": "), i(2, "description") }),
})
