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
            }
        }
    },
    init = function()
        vim.keymap.set("n", "<leader>e", "<Cmd>Neotree<CR>")
    end
}
