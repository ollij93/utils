return {
    {
        "mason-org/mason-lspconfig.nvim",
        lazy=false,
        opts = {
            auto_install = true,
            --ensure_installed = { "lua_ls" },
            --automatic_enable = false
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            {
                "neovim/nvim-lspconfig",
                config = function()
                    -- local lspconfig = require("lspconfig")
                    vim.lsp.config("lua_ls", {})

                    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
                    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
                    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
                end
            }
        },
    },
}
