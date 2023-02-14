return {
	{
		"j-hui/fidget.nvim",
		event = { "BufReadPre", "BufNewFile" },

		config = function()
			require("fidget").setup {
				text = {
					spinner = "moon",
				},

				align = {
					bottom = true,
				},

				window = {
					relative = "editor",
				},
			}
		end,
	},
}
