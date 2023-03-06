return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },

		keys = {
			{ "<leader>li", "<cmd>LspInfo<CR>" },
			{ "<leader>lr", "<cmd>LspRestart<CR>" },
		},

		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"nvim-telescope/telescope.nvim",

			{
				"hrsh7th/cmp-nvim-lsp",
				cond = function()
					return require("lazy.core.config").plugins["nvim-cmp"] ~= nil
				end,
			},

			{
				"lvimuser/lsp-inlayhints.nvim",

				opts = {
					inlay_hints = {
						highlight = "Whitespace",
						labels_separator = "",

						parameter_hints = {
							prefix = " <- ",
						},

						type_hints = {
							prefix = " => ",
							remove_colon_start = true,
						},
					},
				},
			},
		},

		config = function()
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
					suffix = "",
				},
			}

			local servers = {
				lua_ls = {
					hints = true,

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

					settings = {
						["rust-analyzer"] = {
							check = {
								command = "clippy",
							},
						},
					},
				},

				html = {},
				pyright = {},
				tsserver = {},
				jsonls = {},
			}

			local format = function()
				local buffer = vim.api.nvim_get_current_buf()
				local has_null_ls = #require("null-ls.sources").get_available(
					vim.bo[buffer].filetype,
					"NULL_LS_FORMATTING"
				) > 0

				vim.lsp.buf.format {
					bufnr = buffer,
					filter = function(client)
						if not has_null_ls then
							return client.name ~= "null-ls"
						end

						return client.name == "null-ls"
					end,
				}
			end

			vim.g.format_on_save = true
			local format_on_save = function(client, buffer)
				if not client.supports_method "textDocument/formatting" then
					return
				end

				vim.keymap.set("n", "<leader>lF", function()
					if not vim.g.format_on_save then
						vim.g.format_on_save = true
						vim.notify "Enabled format on save"
					else
						vim.g.format_on_save = not vim.g.format_on_save
						vim.notify "Disabled format on save"
					end
				end, { buffer = buffer, desc = "Toggle format on save" })

				local group = vim.api.nvim_create_augroup("FormatOnSave." .. buffer, {})
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = group,
					buffer = buffer,
					callback = function()
						if vim.g.format_on_save then
							format()
						end
					end,
				})
			end

			---@diagnostic disable-next-line: unused-local
			local function on_attach(client, buffer)
				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, remap = false, desc = desc })
				end

				map("n", "K", vim.lsp.buf.hover, "Show documentation")
				map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
				map("n", "gd", require("telescope.builtin").lsp_definitions, "Go to definition(s)")
				map("n", "gr", require("telescope.builtin").lsp_references, "Go to reference(s)")
				map("n", "gi", require("telescope.builtin").lsp_implementations, "Go to implementation(s)")

				map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")
				map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")

				map("n", "<leader>vd", vim.diagnostic.open_float, "Open diagnostic in float")
				map("n", "<leader>vD", require("telescope.builtin").diagnostics, "Show all diagnostics")

				map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
				map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
				map("n", "<leader>lf", format, "Format")
				map({ "i", "s" }, "<C-s>", vim.lsp.buf.signature_help, "Signature help")
			end

			vim.tbl_deep_extend("force", capabilities, default_capabilities)
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			for server, config in pairs(servers) do
				local custom_on_attach

				if config.on_attach then
					custom_on_attach = config.on_attach
				end

				config.on_attach = function(client, buffer)
					if config.hints == true then
						require("lsp-inlayhints").on_attach(client, buffer)
					end

					format_on_save(client, buffer)

					if type(custom_on_attach) == "function" then
						custom_on_attach(client, buffer)
					end

					on_attach(client, buffer)
				end

				config.capabilities = capabilities

				lspconfig[server].setup(config)
			end
		end,
	},
}
