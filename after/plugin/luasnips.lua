local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {
	history = true,
	enable_autosnippets = true,

	-- dynamic snippets, updates as you type
	updateevents = "TextChanged,TextChangedI",

	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { " <- Current Choice", "NonTest" } },
			},
		},
	},
}

local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
local i = ls.insert_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_nodelocal
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets(nil, {
	go = {
		s(
			"init",
			fmt(
				[[
					func init() {{
						{}
					}}
				]],
				{ i(1) }
			)
		),
		s(
			"err",
			fmt(
				[[
					if err != nil {{
						{}
					}}
				]],
				{ i(1, "log.Fatal(err)") }
			)
		),
	},
})
