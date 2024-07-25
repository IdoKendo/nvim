local luasnip = require("luasnip")

local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

luasnip.add_snippets("go", {
    s("if err != nil", {
        t({ "if err != nil {", "\treturn " }),
        i(1, "err"),
        t({ "", "}" }),
    }),
})
