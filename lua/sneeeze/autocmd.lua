local api = vim.api

-- NOTE: if no pattern is set, pattern will be set to "*"

-- FIXME
-- local YankGroup = api.nvim_create_augroup("YankHighlight", { clear = true })
-- api.nvim_create_autocmd("TextYankPost", {
-- 	group = YankGroup,
-- 	callback = function()
-- 		vim.highlight.on_yank {
-- 			higroup = "Substitute",
-- 		}
-- 	end,
-- })

local SpellGroup = api.nvim_create_augroup("Spell", { clear = true })
api.nvim_create_autocmd("FileType", {
	group = SpellGroup,
	pattern = { "markdown", "text" },
	command = "setlocal spell!",
})

local vimwikiGroup = api.nvim_create_augroup("wikiMarkdown", { clear = true })
api.nvim_create_autocmd("FileType", {
	group = vimwikiGroup,
	pattern = "vimwiki",
	command = "MarkdownPreviewToggle",
})

-- :help fo-table
local foGroup = api.nvim_create_augroup("FormatOptions", { clear = true })
api.nvim_create_autocmd("FileType", {
	group = foGroup,
	callback = function()
		vim.opt.fo = vim.opt.fo - "a" - "t" - "o" + "c" + "q" + "r" - "n" + "j"
	end,
})
