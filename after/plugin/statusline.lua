local subscribe = require "el.subscribe"
local sections = require "el.sections"
local builtin = require "el.builtin"
local extensions = require "el.extensions"

local mode = extensions.gen_mode {
	format_string = "[%s]",
}

local filetype_icon = subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, bufnr)
	local icon = extensions.file_icon(_, bufnr)

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
