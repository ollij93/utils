-- Set tabs to 4 spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Display line numbers
vim.cmd("set number")

-- Set leader to SPACE
vim.g.mapleader = " "

-- LAZY VIM INITIALIZATION
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- PLUGIN REGISTRATION
local plugins = {
    -- Dracula color theme
    {
        "dracula/vim",
        name = "dracula",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("dracula")
        end,
    },
    -- Telescope, for fuzzy finding files.
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        }
    },
    -- Treesitter for highlighting, indenting, folding, etc
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate'
    },
    -- Neo-tree for tree view of filesystem
    {
      "nvim-neo-tree/neo-tree.nvim",
      version = '*',
      dependencies = {
          "nvim-lua/plenary.nvim",
          "MunifTanjim/nui.nvim",
          "nvim-tree/nvim-web-devicons", -- optional, but recommended
      },
      lazy = false, -- neo-tree will lazily load itself
    }
}
local opts = {}

require("lazy").setup(plugins, opts)

-- Setup some personal bindings
vim.keymap.set('n', '<leader>ln', "<cmd>set invnumber<CR>", {
    desc = "Toggle line numbers",
})
vim.keymap.set('n', '<leader>rn', "<cmd>set invrelativenumber<CR>", {
    desc = "Toggle relative line numbers",
})
vim.keymap.set("n", "<leader>c", function()
    vim.cmd("nohlsearch")
    vim.fn.setreg("/", "")
end, {
    desc = "Clear current search",
})

-- Setup telescope
local telescope = require('telescope')
telescope.setup {
    pickers = {
        find_files = {
            find_command = {
                "rg",
                "--files",
                "--hidden",
                "--ignore-file-case-insensitive",
                "--glob",
                "!.git/*",
            }
        }
    }
}
-- Telescope bindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Setup treesitter config
require('nvim-treesitter').install { 'rust', 'python', 'lua' }

-- Setup neo-tree config
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree<CR>")
require('neo-tree').setup {
    filesystem = {
        filtered_items = {
            visible = true,
            hide_dotfiles = false
        }
    }
}
