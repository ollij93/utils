local lsps = {"lua_ls", "basedpyright"};

return {
    {
        "mason-org/mason-lspconfig.nvim",
        lazy=false,
        opts = {
            ensure_installed = lsps
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            {
                "neovim/nvim-lspconfig",
                config = function()
                    for _, lsp in ipairs(lsps) do
                        vim.lsp.config(lsp, {})
                    end
                end,
                keys = {
                    {"K", vim.lsp.buf.hover, {}},
                    {"<leader>gd", vim.lsp.buf.definition, {}},
                    {"<leader>gr", vim.lsp.buf.references, {}},
                    {"<leader>ca", vim.lsp.buf.code_action, {}}
                }

            },
        },
    },
}
