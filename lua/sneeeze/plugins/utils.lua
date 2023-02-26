return {
	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	},

	-- Discord presence
	{
		"andweeb/presence.nvim",
		event = { "BufReadPost", "BufNewFile" },

		config = function()
			require("presence"):setup {
				neovim_image_text = "Neovim",
				main_image = "file",
			}
		end,
	},

	{
		"mbbill/undotree",

		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<CR>" },
		},
	},

	{
		"vimwiki/vimwiki",

		keys = {
			{ "<leader>ww", desc = "VimwikiIndex" },
			{ "<leader>wt", desc = "VimwikiTabIndex" },
			{ "<leader>ws", desc = "VimwikiUISelect" },
			{ "<leader>wi", desc = "VimwikiDiaryIndex" },

			{ "<leader>w<leader>i", desc = "VimwikiDiaryGenerateLinks" },
			{ "<leader>w<leader>w", desc = "VimwikiMakeDiaryNote" },
			{ "<leader>w<leader>t", desc = "VimwikiTabMakeDiaryNote" },
			{ "<leader>w<leader>y", desc = "VimwikiMakeYesterdayDiaryNote" },
			{ "<leader>w<leader>m", desc = "VimwikiMakeTomorrowDiaryNote" },
		},

		config = function()
			vim.g.vimwiki_list = {
				{
					path = "~/.local/share/vimwiki/",
					syntax = "markdown",
					ext = ".md",
				},
			}

			vim.g.vimwiki_global_ext = 0

			vim.fn["vimwiki#vars#init"]()
		end,
	},

	{
		"tpope/vim-eunuch",
		keys = {
			{
				"<leader>r",
				function()
					local old_name = vim.fn.expand "%:t"
					local new_name = vim.fn.input("New file name: ", old_name)

					if new_name == "" or new_name == old_name then
						print()
						return
					end

					vim.cmd("Rename " .. new_name)
				end,
				desc = "Rename current file",
			},
		},
	},

	{
		"brenoprata10/nvim-highlight-colors",
		event = "VeryLazy",

		config = function()
			require("nvim-highlight-colors").setup {
				render = "background",
				enable_named_colors = true,
				enable_tailwind = true,
			}
		end,
	},
}
