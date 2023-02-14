return {
	{
		"tpope/vim-fugitive",

		cmd = "Git",

		keys = {
			{ "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
			{ "<leader>gl", "<cmd>Git log<CR>", desc = "Git log" },
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },

		cmd = "Gitsigns",

		config = function()
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

				on_attach = function(buffer)
					local function map(mode, l, r, desc)
						vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
					end

					map("n", "]g", "<cmd>Gitsigns next_hunk<CR>", "Next git hunk")
					map("n", "[g", "<cmd>Gitsigns prev_hunk<CR>", "Previous git hunk")
					map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk")
					map("n", "<leader>grh", "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk")
					map("n", "<leader>grb", "<cmd>Gitsigns reset_buffer<CR>", "Reset buffer")
					map({ "x", "o" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
				end,
			}
		end,
	},
}
