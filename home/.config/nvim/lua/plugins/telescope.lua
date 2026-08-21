-- Telescope, for fuzzy finding files.
local searchopts = {
    "--hidden",
    "--ignore-file-case-insensitive",
    "--follow",
}
local globopts = {
    "--glob",
    "!.git/*",
    "--glob",
    "!.snapshot/*",
    "--glob",
    "!.cache/*",
}
return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		opts = {
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
                    unpack(searchopts),
                    unpack(globopts)
				},
			},
			pickers = {
				find_files = {
					find_command = {
						"rg",
						"--files",
                        unpack(searchopts),
                        unpack(globopts)
					},
				},
			},
		},
		keys = {
			{ "<leader>ff", "<Cmd>Telescope find_files<CR>", { desc = "Telescope find files" } },
			{ "<leader>fg", "<Cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" } },
			{ "<leader>fb", "<Cmd>Telescope buffers<CR>", { desc = "Telescope buffers" } },
			{ "<leader>fh", "<Cmd>Telescope help_tags<CR>", { desc = "Telescope help tags" } },
		},
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	},
}
