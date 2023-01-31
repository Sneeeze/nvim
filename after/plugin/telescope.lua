local telescope = require "telescope"
local actions = require "telescope.actions"

telescope.setup {
	defaults = {
		path_display = { "truncate" },
		file_ignore_patterns = { ".git/", "target/" },

		multi_icon = " *",
		sorting_strategy = "ascending",
		layout_strategy = "bottom_pane",
		layout_config = {
			height = 25,
		},

		border = true,
		borderchars = {
			prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
			results = { " " },
			preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		},

		mappings = {
			i = {
				["<C-s>"] = actions.select_horizontal,
				["<C-j>"] = actions.cycle_history_next,
				["<C-k>"] = actions.cycle_history_prev,
			},
		},
	},

	pickers = {
		find_files = {
			no_ignore = true,
			hidden = true,
		},
	},

	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
}

require("telescope").load_extension "fzf"
