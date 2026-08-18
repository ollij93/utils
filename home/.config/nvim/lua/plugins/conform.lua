return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	keys = {
		{
			"<leader>cF",
			function()
				require("conform").format()
			end,
			mode = { "n", "x" },
			desc = "Format file",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			fish = { "fish_indent" },
            python = { "black" },
		},
	},
}
