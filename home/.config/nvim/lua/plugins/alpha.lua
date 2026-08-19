return {
	"goolord/alpha-nvim",
	opts = function()
		local startify = require("alpha.themes.startify")
		local logo = [[
         ▄▄    ▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄ ▄▄   ▄▄ 
        █  █  █ █       █       █  █ █  █   █  █▄█  █
        █   █▄█ █    ▄▄▄█   ▄   █  █▄█  █   █       █
        █       █   █▄▄▄█  █ █  █       █   █       █
        █  ▄    █    ▄▄▄█  █▄█  █       █   █       █
        █ █ █   █   █▄▄▄█       ██     ██   █ ██▄██ █
        █▄█  █▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█ █▄▄▄█ █▄▄▄█▄█   █▄█
        ]]
		startify.section.header.val = vim.split(logo, "\n")
		startify.config.opts.keymap = {
			press = {
				"<CR>",
				"<2-LeftMouse>",
			},
		}
		return startify.opts
	end,
}
