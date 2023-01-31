require("Comment").setup {
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
