return {
	{
		"simrat39/inlay-hints.nvim",
		event = { "BufReadPre", "BufNewFile" },

		config = function()
			require("inlay-hints").setup {
				renderer = "inlay-hints/render/eol",

				hints = {
					parameter = {
						show = true,
						highlight = "Whitespace",
					},
					type = {
						show = true,
						highlight = "Whitespace",
					},
				},

				only_current_line = false,

				eol = {
					right_align = false,

					right_align_padding = 7,

					parameter = {
						separator = ", ",
						format = function(hints)
							return string.format(" <- (%s)", hints)
						end,
					},

					type = {
						separator = ", ",
						format = function(hints)
							return string.format(" => %s", hints)
						end,
					},
				},
			}
		end,
	},
}
