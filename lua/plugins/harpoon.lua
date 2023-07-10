return {
    "theprimeagen/harpoon",
    keys = {
        { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "[A]dd file to Harpoon" },
        { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle Harpoon menu" },
        { "<C-t>", function() require("harpoon.ui").nav_file(1) end, desc = "Jump to Harpoon 1" },
        { "<C-y>", function() require("harpoon.ui").nav_file(2) end, desc = "Jump to Harpoon 2" },
        { "<C-u>", function() require("harpoon.ui").nav_file(3) end, desc = "Jump to Harpoon 3" },
    }
}
