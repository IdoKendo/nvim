vim.pack.add({
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/theHamsta/nvim-dap-virtual-text",
    "https://github.com/nvim-neotest/nvim-nio",
})

local dap_core_configured = false
local python_dap_configured = false
local go_dap_configured = false

local function path_exists(path)
    local stat = vim.uv.fs_stat(path)
    return stat ~= nil
end

local function detect_python_project_root()
    local markers = { "pyproject.toml", "setup.cfg", "setup.py", "requirements.txt", ".git" }
    local buf_path = vim.api.nvim_buf_get_name(0)
    local start_path = buf_path ~= "" and vim.fs.dirname(buf_path) or vim.fn.getcwd()
    local found = vim.fs.find(markers, { path = start_path, upward = true })[1]

    if found then
        return vim.fs.dirname(found)
    end

    return nil
end

local function resolve_python_debug_cwd()
    local project_root = detect_python_project_root()
    local current_working_directory = vim.fn.getcwd()

    if project_root then
        local project_src = project_root .. "/src"
        if path_exists(project_src) then
            return project_src
        end

        return project_root
    end

    if path_exists(current_working_directory) then
        return current_working_directory
    end

    local uv_cwd = vim.uv.cwd()
    if uv_cwd and uv_cwd ~= "" then
        return uv_cwd
    end

    return vim.fn.expand("~")
end

local function setup_core_dap()
    if dap_core_configured then
        return
    end

    local dap = require("dap")
    local ui = require("dapui")

    ui.setup({
        controls = {
            element = "repl",
            enabled = true,
            icons = {
                disconnect = "",
                pause = "",
                play = "",
                run_last = "",
                step_back = "",
                step_into = "",
                step_out = "",
                step_over = "",
                terminate = "",
            },
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
            border = "single",
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        force_buffers = true,
        icons = {
            collapsed = "",
            current_frame = "",
            expanded = "",
        },
        layouts = {
            {
                elements = {
                    { id = "scopes", size = 0.5 },
                    { id = "watches", size = 0.5 },
                },
                size = 40,
                position = "right",
            },
            {
                elements = { "repl" },
                size = 10,
                position = "bottom",
            },
        },
        mappings = {
            edit = "e",
            expand = { "<CR>" },
            open = "o",
            remove = "d",
            repl = "r",
            toggle = "t",
        },
        render = {
            indent = 2,
            max_value_lines = 100,
        },
    })

    require("nvim-dap-virtual-text").setup({
        virt_lines = false,
        virt_text_pos = "eol",
    })

    dap.set_log_level("DEBUG")

    vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

    vim.keymap.set("n", "<leader>rc", dap.continue, { desc = "[R]un [C]ontinue" })
    vim.keymap.set("n", "<leader>rs", dap.step_over, { desc = "[R]un [S]tep Over" })
    vim.keymap.set("n", "<leader>ri", dap.step_into, { desc = "[R]un Step [I]nto" })
    vim.keymap.set("n", "<leader>ro", dap.step_out, { desc = "[R]un Step [O]ut" })
    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle [B]reakpoint" })
    vim.keymap.set("n", "<leader>rb", dap.run_to_cursor, { desc = "[R]un to cursor and [B]reakpoint" })
    vim.keymap.set("n", "<leader>re", ui.eval, { desc = "[R]un [E]val" })
    vim.keymap.set("n", "<leader>rk", dap.terminate, { desc = "[R]un [K]ill" })
    vim.keymap.set("n", "<leader>rT", ui.toggle, { desc = "[R]un [T]oggle UI" })

    dap.listeners.before.attach.dapui_config = function()
        ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        ui.open()
    end

    dap_core_configured = true
end

local function get_test_description()
    local node = vim.treesitter.get_node()
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
        args = { "--ginkgo.no-color" },
    }

    require("dap").run(config)

    return true
end

setup_core_dap()

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        if python_dap_configured then
            return
        end

        vim.pack.add({ "https://github.com/mfussenegger/nvim-dap-python" })

        local dap_python = require("dap-python")
        local dap = require("dap")

        dap_python.setup("debugpy-adapter")
        dap_python.test_runner = "pytest"

        dap.configurations.python = dap.configurations.python or {}
        table.insert(dap.configurations.python, {
            name = "Debug test",
            type = "python",
            request = "launch",
            module = "pytest",
            args = {
                "${file}",
                "-sv",
                "--log-cli-level=INFO",
                "--log-file=test_out.log",
            },
            console = "integratedTerminal",
        })
        table.insert(dap.configurations.python, {
            name = "Debug code",
            type = "python",
            request = "launch",
            cwd = function()
                return resolve_python_debug_cwd()
            end,
            program = "${file}",
        })

        python_dap_configured = true
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        if go_dap_configured then
            return
        end

        vim.pack.add({ "https://github.com/leoluz/nvim-dap-go" })

        local dap_go = require("dap-go")

        dap_go.setup({
            delve = {
                build_flags = { "-tags=cloud" },
            },
        })

        vim.keymap.set("n", "<leader>rt", dap_go.debug_test, { desc = "[R]un [T]est" })
        vim.keymap.set("n", "<leader>rg", debug_ginko_test, { desc = "[R]un [G]inkgo test" })

        go_dap_configured = true
    end,
})
