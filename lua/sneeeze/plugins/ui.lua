return {
	-- Theme
	{
		"catppuccin/nvim",
		priority = 1000,
		lazy = false,
		name = "catppuccin",

		config = function()
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
						TabLine = { fg = colors.overlay1, bg = colors.mantle },
						TabLineSel = { fg = colors.text, bg = colors.surface0 },
					}
				end,
			}

			vim.cmd.colorscheme "catppuccin"
		end,
	},

	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require "notify"
		end,
	},

	-- Statusline
	{
		"tjdevries/express_line.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			local subscribe = require "el.subscribe"
			local sections = require "el.sections"
			local builtin = require "el.builtin"
			local extensions = require "el.extensions"

			local mode = extensions.gen_mode {
				format_string = "[%s]",
			}

			local filetype_icon = subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, buffer)
				local icon = extensions.file_icon(_, buffer)

				if icon then
					return icon .. " "
				end

				return ""
			end)

			local git_branch = subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
				local branch = extensions.git_branch(window, buffer)

				if branch then
					return "  " .. branch
				end
			end)

			local git_changes = subscribe.buf_autocmd("el_git_changes", "BufWritePost", function(window, buffer)
				return extensions.git_changes(window, buffer)
			end)

			local diagnostics = require("el.diagnostic").make_buffer()

			require("el").setup {
				generator = function()
					return {
						mode,
						git_branch,
						sections.collapse_builtin {
							" ",
							diagnostics,
						},

						sections.split,

						filetype_icon,
						builtin.tail,
						sections.collapse_builtin {
							" ",
							builtin.modified_flag,
						},

						sections.split,

						git_changes,
						"[",
						builtin.line_with_width(3),
						":",
						builtin.column_with_width(2),
						"]",
						builtin.filetype,
					}
				end,
			}
		end,
	},

	{
		"folke/which-key.nvim",
		config = true,
	},

	{
		"crispgm/nvim-tabline",
		event = "VimEnter",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			require("tabline").setup {
				show_icon = true,
			}

			vim.opt.showtabline = 1
		end,
	},

	"stevearc/dressing.nvim",
}
