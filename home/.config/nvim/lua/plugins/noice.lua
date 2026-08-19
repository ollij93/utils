return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
        -- Route the shell command output to display in a noice view
        routes = {
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
