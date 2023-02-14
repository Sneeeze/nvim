return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },

		dependencies = {
			"romgrk/nvim-treesitter-context",
		},

		config = function()
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
			}
		end,
	},

	{
		"echasnovski/mini.ai",

		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},

		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					require("lazy.core.loader").disable_rtp_plugin "nvim-treesitter-textobjects"
				end,
			},
		},

		config = function()
			local ai = require "mini.ai"
			ai.setup {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				},
			}
		end,
	},
}
