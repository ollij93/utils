-- Treesitter for highlighting, indenting, folding, etc
return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').install { 'rust', 'python', 'lua', 'toml' }
    end
}

