return {
	{
		"nvim-telescope/telescope.nvim",

		cmd = "Telescope",

		keys = {
			{ "<C-p>", "<cmd>Telescope find_files<CR>", desc = "Find files" },
			{ "z=", "<cmd>Telescope spell_suggest<CR>", desc = "Spell suggest" },
			{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
			{ "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Old files" },
			{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
		},

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},

		config = function()
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
		end,
	},

	{
		"ThePrimeagen/harpoon",

		keys = {
			{
				"<leader>a",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Add file to harpoon",
			},
			{
				"<C-e>",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "Open harpoon quick menu",
			},
			{
				"<C-h>",
				function()
					require("harpoon.ui").nav_file(1)
				end,
				desc = "Navigate to first harpoon file",
			},
			{
				"<C-t>",
				function()
					require("harpoon.ui").nav_file(2)
				end,
				desc = "Navigate to second harpoon file",
			},
			{
				"<C-n>",
				function()
					require("harpoon.ui").nav_file(3)
				end,
				desc = "Navigate to third harpoon file",
			},
			{
				"<C-s>",
				function()
					require("harpoon.ui").nav_file(4)
				end,
				desc = "Navigate to fourth harpoon file",
			},
		},

		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
