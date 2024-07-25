local luasnip = require("luasnip")

local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

luasnip.add_snippets("python", {
    s("def main()", {
        t({ "def main() -> None:", "    " }),
        i(1, "..."),
        t({ "", "", "", 'if __name__ == "__main__":', "    main()", "" }),
    }),
})
