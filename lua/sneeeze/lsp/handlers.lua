local lspconfig = require "lspconfig"
local capabilities = vim.lsp.protocol.make_client_capabilities()
local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

local signs = {
	{ texthl = "DiagnosticSignError", text = "E" },
	{ texthl = "DiagnosticSignWarn", text = "W" },
	{ texthl = "DiagnosticSignHint", text = "H" },
	{ texthl = "DiagnosticSignInfo", text = "I" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.texthl, { texthl = sign.texthl, text = sign.text })
end

require("lspconfig.ui.windows").default_options = {
	border = "rounded",
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

vim.diagnostic.config {
	signs = nil,
	virtual_text = true,
	underline = true,
	update_in_insert = true,
	severity_sort = true,

	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

local servers = {
	sumneko_lua = {
		hints = true,
		prefer_nulls = true,

		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = vim.split(package.path, ";"),
				},

				diagnostics = {
					globals = {
						"vim",
						"awesome",
						"client",
						"root",
						"screen",
					},
				},

				completion = {
					callSnippet = "Replace",
					autoRequire = false,
				},

				workspace = {
					library = {
						[vim.fn.expand "$VIMRUNTIME/lua"] = true,
						[vim.fn.stdpath "config" .. "/lua"] = true,
						["/usr/share/awesome/lib"] = true,
					},
					maxPreload = 1000,
					preloadFileSize = 150,
				},

				telemetry = {
					enable = false,
				},

				hint = {
					enable = true,
				},
			},
		},
	},

	gopls = {
		hints = true,

		settings = {
			gopls = {
				staticcheck = true,
				deepCompletion = true,
				verboseOutput = true,
				usePlaceholders = true,
				completeUnimported = true,
				completionDocumentation = true,
				symbolStyle = "Full",

				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},

				analyses = {
					unusedparams = true,
				},
			},
		},
	},

	rust_analyzer = {
		hints = true,
		prefer_nulls = true,

		settings = {
			rust_analyzer = {
				cargo = {
					loadOutDirsFromCheck = true,
				},
			},
		},
	},

	html = {},
	pyright = {},
	tsserver = {},
	jsonls = {},
}

local function on_attach(client, bufnr)
	local map = vim.keymap.set
	local opts = { buffer = bufnr, remap = false }

	map("n", "K", vim.lsp.buf.hover, opts)
	map("n", "gD", vim.lsp.buf.declaration, opts)
	map("n", "gd", require("telescope.builtin").lsp_definitions, opts)
	map("n", "gr", require("telescope.builtin").lsp_references, opts)
	map("n", "gi", require("telescope.builtin").lsp_implementations, opts)

	map("n", "]d", vim.diagnostic.goto_next, opts)
	map("n", "[d", vim.diagnostic.goto_prev, opts)

	map("n", "<leader>vd", vim.diagnostic.open_float, opts)
	map("n", "<leader>vD", require("telescope.builtin").diagnostics, opts)

	map("n", "<leader>cr", vim.lsp.buf.rename, opts)
	map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	map("n", "<leader>lf", vim.lsp.buf.format, opts)
	map({ "i", "s" }, "<C-s>", vim.lsp.buf.signature_help, opts)
end

local function format_on_save(bufnr)
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format()
		end,
	})
end

vim.tbl_deep_extend("force", capabilities, default_capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = false

for server, config in pairs(servers) do
	local custom_on_attach
	if config.on_attach then
		custom_on_attach = config.on_attach
	end

	config.on_attach = function(client, bufnr)
		-- FIXME:  some lsps not showing hints until you edit something
		if config.hints == true then
			require("inlay-hints").on_attach(client, bufnr)
		end

		if config.prefer_nulls == true then
			client.server_capabilities.documentFormattingProvider = false
		end

		if config.format_on_save ~= false then
			format_on_save(bufnr)
		end

		if type(custom_on_attach) == "function" then
			custom_on_attach(client, bufnr)
		end

		on_attach(client, bufnr)
	end

	config.capabilities = capabilities

	lspconfig[server].setup(config)
end
