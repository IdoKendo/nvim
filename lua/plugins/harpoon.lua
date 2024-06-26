return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        require("harpoon"):setup()
        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "[A]dd to Harpoon" })
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)
        vim.keymap.set("n", "<C-t>", function()
            harpoon:list():select(1)
        end)
        vim.keymap.set("n", "<C-y>", function()
            harpoon:list():select(2)
        end)
    end,
}
