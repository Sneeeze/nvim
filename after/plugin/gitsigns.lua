require("gitsigns").setup {
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "▎" },
		changedelete = { text = "▎" },
		topdelete = { text = "契" },
		untracked = { text = "▎" },
	},

	current_line_blame = true,
	current_line_blame_opts = {
		virt_text_pos = "right_align",
		delay = 2000,
	},

	preview_config = {
		border = "rounded",
	},
}
