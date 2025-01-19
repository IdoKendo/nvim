local ts_utils = require("nvim-treesitter.ts_utils")

local function get_test_description()
    local node = ts_utils.get_node_at_cursor()
    while node do
        if node:type() == "call_expression" then
            local first_child = node:child(0)
            if first_child and first_child:type() == "identifier" then
                local func_name = vim.treesitter.get_node_text(first_child, 0)
                if func_name == "When" or func_name == "Describe" or func_name == "It" then
                    local args = node:child(1)
                    if args and args:type() == "argument_list" then
                        local test_description = args:child(1)
                        if test_description then
                            return vim.treesitter.get_node_text(test_description, 0)
                        end
                    end
                end
            end
        end
        node = node:parent()
    end
    return nil
end

local function debug_ginko_test()
    local test = get_test_description()

    if test == "" or test == nil then
        vim.notify("no test found")
        return false
    end

    local pkg = ""
    for w in string.gmatch(vim.fn.expand("%"), "(.*)/") do
        pkg = pkg .. w
    end
    pkg = "./" .. pkg .. "/..."

    local msg = string.format("starting debug session '%s : %s'...", pkg, test)
    vim.notify(msg)

    local config = {
        type = "go",
        name = test,
        request = "launch",
        mode = "test",
        program = pkg,
        args = { "--ginkgo.no-color" }, -- , "--ginkgo.focus", test }, -- FIXME: when I add the test focus it doesn't respect breakpoint
    }

    require("dap").run(config)

    return true
end

vim.keymap.set("n", "<leader>rg", debug_ginko_test, { desc = "[R]un [G]inkgo test" })
