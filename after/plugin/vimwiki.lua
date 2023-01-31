vim.g.vimwiki_list = {
	{
		path = "~/.local/share/vimwiki/",
		syntax = "markdown",
		ext = ".md",
	},
}

vim.g.vimwiki_global_ext = 0

vim.fn["vimwiki#vars#init"]()
