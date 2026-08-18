-- Neo-tree for tree view of filesystem
return {
    "nvim-neo-tree/neo-tree.nvim",
    version = '*',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    opts = {
        filesystem = {
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                never_show = {
                    ".git",
                }
            }
        }
    },
    keys = {
        {"<leader>e", "<Cmd>Neotree<CR>", { desc = "Open Neotree" }},
    }
}
