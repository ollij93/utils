-- Treesitter for highlighting, indenting, folding, etc
return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    opts = {
        autoinstall = true,
    },
}

