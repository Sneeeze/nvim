require("catppuccin").setup {
	flavour = "mocha",

	background = {
		light = "latte",
		dark = "mocha",
	},

	styles = {
		comments = { "italic" },
		functions = { "bold" },
	},

	integrations = {
		fidget = true,
		harpoon = true,
		notify = true,
		vimwiki = true,
		which_key = true,
		treesitter_context = true,

		native_lsp = {
			enabled = true,

			virtual_text = {
				errors = {},
				hints = {},
				warnings = {},
				information = {},
			},

			underlines = {
				errors = { "undercurl" },
				hints = { "undercurl" },
				warnings = { "undercurl" },
				information = { "undercurl" },
			},
		},
	},

	custom_highlights = function(colors)
		return {
			DiagnosticVirtualTextHint = { bg = colors.none },
			DiagnosticVirtualTextInfo = { bg = colors.none },
			DiagnosticVirtualTextWarn = { bg = colors.none },
			DiagnosticVirtualTextError = { bg = colors.none },
		}
	end,
}

vim.cmd.colorscheme "catppuccin"
