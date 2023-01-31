local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	ui = {
		wrap = false,
		border = "rounded",
		size = {
			width = 0.9,
			height = 0.85,
		},
	},
}

local plugins = {
	-- Theme
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},

	-- Git
	"lewis6991/gitsigns.nvim",
	"tpope/vim-fugitive",

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	"romgrk/nvim-treesitter-context",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"JoosepAlviste/nvim-ts-context-commentstring",

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},

	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- Pretty stuff:
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
	},

	-- Tabline
	"mkitt/tabline.vim",

	-- Selecting code actions via telescope etc.
	"stevearc/dressing.nvim",

	-- Text manipulation:
	"numToStr/Comment.nvim",
	"AndrewRadev/splitjoin.vim",

	{
		"tpope/vim-surround",
		dependencies = {
			"tpope/vim-repeat",
		},
	},

	-- Other:
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	},

	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	-- Discord presence
	{
		"andweeb/presence.nvim",
		config = function()
			require("presence"):setup {
				neovim_image_text = "Neovim",
				main_image = "file",
			}
		end,
	},

	"vimwiki/vimwiki",
	"tpope/vim-eunuch",
	"brenoprata10/nvim-highlight-colors",
	"machakann/vim-highlightedyank",

	-- Lsp
	"neovim/nvim-lspconfig",
	"j-hui/fidget.nvim",
	"simrat39/inlay-hints.nvim",
	"jose-elias-alvarez/null-ls.nvim",

	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	-- Autocomplete
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-nvim-lsp",
	"saadparwaiz1/cmp_luasnip",

	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup {
				check_ts = true,
				map_c_h = true,
				map_c_w = true,
			}
		end,
	},

	-- Snippets
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
}

return require("lazy").setup(plugins, opts)
