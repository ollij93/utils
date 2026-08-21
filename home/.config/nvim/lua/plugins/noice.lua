return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
        presets = {
            command_palette = true,
            long_message_to_split = true,
            lsp_doc_border = true,
        },
        routes = {
            -- Route the shell command output to display in a noice view
            {
                view = "popup",
                filter = {
                    event = "msg_show",
                    kind = {
                        "shell_out",
                        "shell_err",
                        "shell_ret",
                    },
                },
            },
        },
    },
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}
