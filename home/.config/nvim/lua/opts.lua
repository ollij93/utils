-- Set tabs to 4 spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Display line numbers
vim.cmd("set number")

-- Set leader to SPACE
vim.g.mapleader = " "

-- Enable virtual text for inline warnings etc
vim.diagnostic.config({
    virtual_text = true
})

-- Setup some personal bindings
vim.keymap.set('n', '<leader>ln', "<cmd>set invnumber<CR>", {
    desc = "Toggle line numbers",
})
vim.keymap.set('n', '<leader>rn', "<cmd>set invrelativenumber<CR>", {
    desc = "Toggle relative line numbers",
})
vim.keymap.set("n", "<leader>c/", function()
    vim.cmd("nohlsearch")
    vim.fn.setreg("/", "")
end, {
    desc = "Clear current search",
})
