return {

	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "mason-org/mason.nvim", config = true },
			"mason-org/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			{ "j-hui/fidget.nvim",    tag = "legacy", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},

		config = function()
			-- Diagnostic keymaps
			-- deprecated - unnecessary:
			-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
			-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })

			vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
			-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

			vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
			vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" })
			vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type [D]efinition" })
			vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols,
				{ desc = "[D]ocument [S]ymbols" })
			vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
				{ desc = "[W]orkspace [S]ymbols" })

			-- See `:help K` for why this keymap
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Documentation" })

			-- Lesser used LSP functionality
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
			vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "[W]orkspace [A]dd Folder" })
			vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
				{ desc = "[W]orkspace [R]emove Folder" })
			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, { desc = "[W]orkspace [L]ist Folders" })

			-- Format custom keymap
			vim.keymap.set('n', '<leader>fc', vim.lsp.buf.format, { desc = "[F]ormat [C]urret Buffer" })

			-- Enable the following language servers
			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- tsserver = {},
				--  html = { filetypes = { 'html', 'twig', 'hbs' } },
				pylsp = {},

				lua_ls = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			}

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- Ensure the servers above are installed
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
				auto_install = false,
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
							settings = servers[server_name],
							filetypes = (servers[server_name] or {}).filetypes,
						})
					end,
				},
			})
		end,
	},
}
