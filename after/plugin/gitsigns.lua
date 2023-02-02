require("gitsigns").setup {
	signs = {
		add = { text = "+" },
		untracked = { text = "+" },
		delete = { text = "▁" },
		topdelete = { text = "▶" },
		change = { text = "~" },
		changedelete = { text = "~" },
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
