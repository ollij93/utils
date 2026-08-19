-- Extra helpers for using venv's for python formatting and lsps
local function uv_wrap_tool(tool)
    return {
        inherit = true,
        command = function()
            return vim.fn.exepath("uv")
        end,
        prepend_args = function(_, context)
            local root = vim.fs.root(context.buf, {
                "uv.lock",
                "pyproject.toml",
            })
            return {
                "run",
                "--no-sync",
                "--project",
                root,
                "--",
                tool,
            }
        end
    }
end

local function uv_wrap_lsp(tool, arguments)
    return function(dispatchers, config)
        local command = {
            vim.fn.exepath("uv"),
            "run",
            "--no-sync",
            "--project",
            config.root_dir,
            "--",
            tool,
        }

        vim.list_extend(command, arguments)

        return vim.lsp.rpc.start(command, dispatchers, {
            cwd = config.root_dir,
        })
    end
end

-- Configure the LSPs and formatters for each language here.
local languages = {
	fish = {
		lsps = {
			fish_lsp = {},
		},
		formatters = { "fish_indent" },
	},
	lua = {
		lsps = {
			lua_ls = {},
		},
		formatters = { "stylua" },
	},
	python = {
		lsps = {
			ruff = {
                cmd = uv_wrap_lsp("ruff", { "server" }),
            },
			ty = {
                cmd = uv_wrap_lsp("ty", { "server" }),
            },
		},
		formatters = { "isort", "black" },
	},
}

local formatters_by_ft = {}
local lsps = {}

for filetype, language in pairs(languages) do
	formatters_by_ft[filetype] = language.formatters

	for lsp, opts in pairs(language.lsps) do
		lsps[lsp] = opts
	end
end

local ensure_installed = vim.tbl_keys(lsps)
table.sort(ensure_installed)

return {
	{ "mason-org/mason.nvim", opts = {} },
	-- LSP configuration
	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			ensure_installed = ensure_installed,
			automatic_enable = true,
		},
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			for lsp, opts in pairs(lsps) do
				vim.lsp.config(lsp, opts)
			end
		end,
		keys = {
			{ "K", vim.lsp.buf.hover, desc = "Look-up documentation" },
			{ "<leader>gd", vim.lsp.buf.definition, desc = "Go to definition" },
			{ "<leader>gr", vim.lsp.buf.references, desc = "Go to references" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code actions" },
		},
	},
    -- Formatting configuration with conform.nvim
	{
		"stevearc/conform.nvim",
		dependencies = { "mason-org/mason.nvim" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format()
				end,
				mode = { "n", "x" },
				desc = "Code format file",
			},
		},
		opts = {
			formatters_by_ft = formatters_by_ft,
            default_format_opts = {
                timeout_ms = 2000,
            },
            formatters = {
                black = uv_wrap_tool("black"),
                isort = uv_wrap_tool("isort"),
            }
		},
	},
}
