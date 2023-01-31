require("nvim-treesitter.configs").setup {
	ensure_installed = "all",
	sync_install = false,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	autopairs = {
		enable = true,
	},

	context_commentstring = {
		enable = true,
	},

	textobjects = {
		move = {
			enable = true,
			set_jumps = true,

			goto_next_start = {
				["]p"] = "@parameter.inner",
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[p"] = "@parameter.inner",
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},

		select = {
			enable = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",

				["ac"] = "@conditional.outer",
				["ic"] = "@conditional.inner",

				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",

				["av"] = "@variable.outer",
				["iv"] = "@variable.inner",
			},
		},
	},
}
