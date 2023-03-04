return {
	"AndrewRadev/splitjoin.vim",

	{
		"kylechui/nvim-surround",

		keys = {
			{ "ys", desc = "Add a surrounding pair around a motion (normal mode)" },
			{ "yss", desc = "Add a surrounding pair around the current line (normal mode)" },
			{ "yS", desc = "Add a surrounding pair around a motion, on new lines (normal mode)" },
			{ "ySS", desc = "Add a surrounding pair around the current line, on new lines (normal mode)" },

			{ "ds", desc = "Delete a surrounding pair" },
			{ "cs", desc = "Change a surrounding pair" },

			{ "S", mode = "x", desc = "Add a surrounding pair around a visual selection" },
			{ "gS", mode = "x", desc = "Add a surrounding pair around a visual selection, on new lines" },

			{ "<C-g>s", mode = "i", desc = "Add a surrounding pair around the cursor (insert mode)" },
			{ "<C-g>S", mode = "i", desc = "Add a surrounding pair around the cursor, on new lines (insert mode)" },
		},

		config = true,
	},

	-- Comments
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
	},

	{
		"numToStr/Comment.nvim",

		keys = {
			{ "gc", mode = { "n", "x" }, desc = "Comment toggle linewise" },
			{ "gb", mode = { "n", "x" }, desc = "Comment toggle blockwise" },
		},

		config = function()
			require("Comment").setup {
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

				opleader = {
					-- line-comment
					line = "gc",
					-- block-comment
					block = "gb",
				},

				mappings = {
					-- operator-pending mapping:
					-- gcc               -> line-comment  the current line
					-- gcb               -> block-comment the current line
					-- gc[count]{motion} -> line-comment  the region contained in {motion}
					-- gb[count]{motion} -> block-comment the region contained in {motion}
					basic = true,

					-- extra mapping:
					-- gco
					-- gcO
					-- gcA
					extra = true,
				},

				toggler = {
					-- line-comment
					line = "gcc",

					-- block-comment
					block = "gbc",
				},

				-- Ignore empty lines
				ignore = "^$",
			}
		end,
	},
}
