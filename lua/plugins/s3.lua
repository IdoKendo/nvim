return {
    "IdoKendo/telescope-s3",
    event = "VeryLazy",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("telescope").load_extension("telescope_s3")
    end,
    keys = {
        { "<leader>s3d", ":Telescope telescope_s3 delete_object<CR>", desc = "[S3] [D]elete" },
        { "<leader>s3r", ":Telescope telescope_s3 read_object<CR>", desc = "[S3] [R]ead" },
        { "<leader>s3w", ":Telescope telescope_s3 write_object<CR>", desc = "[S3] [W]rite" },
    },
}
