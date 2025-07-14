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
			-- deprecated:
			-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
			-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })

			-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
			-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

			-- [[ Configure LSP ]]
			--  This function gets run when an LSP connects to a particular buffer.
			local on_attach = function(_, bufnr)
				-- NOTE: Remember that lua is a real programming language, and as such it is possible
				-- to define small helper and utility functions so you don't have to repeat yourself
				-- many times.
				--
				-- In this case, we create a function that lets us more easily define mappings specific
				-- for LSP related items. It sets the mode, buffer and description for us each time.
				-- local nmap = function(keys, func, desc)
				-- 	if desc then
				-- 		desc = "LSP: " .. desc
				-- 	end
				--
				-- 	vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				-- end

				-- vim.keymap.set("<leader>rn", "n", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })

				vim.keymap.set("ga", "n", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
				vim.keymap.set("gd", "n", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
				vim.keymap.set("gr", "n", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" })
				vim.keymap.set("gI", "n", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
				vim.keymap.set("<leader>D", "n", vim.lsp.buf.type_definition, { desc = "Type [D]efinition" })
				vim.keymap.set("<leader>ds", "n", require("telescope.builtin").lsp_document_symbols,
					{ desc = "[D]ocument [S]ymbols" })
				vim.keymap.set("<leader>ws", "n", require("telescope.builtin").lsp_dynamic_workspace_symbols,
					{ desc = "[W]orkspace [S]ymbols" })

				-- See `:help K` for why this keymap
				vim.keymap.set("K", "n", vim.lsp.buf.hover, { desc = "Hover Documentation" })
				vim.keymap.set("<C-k>", "n", vim.lsp.buf.signature_help, { desc = "Signature Documentation" })

				-- Lesser used LSP functionality
				vim.keymap.set("gD", "n", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
				vim.keymap.set("<leader>wa", "n", vim.lsp.buf.add_workspace_folder, { desc = "[W]orkspace [A]dd Folder" })
				vim.keymap.set("<leader>wr", "n", vim.lsp.buf.remove_workspace_folder,
					{ desc = "[W]orkspace [R]emove Folder" })
				vim.keymap.set("<leader>wl", "n", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, { desc = "[W]orkspace [L]ist Folders" })

				-- Create a command `:Format` local to the LSP buffer
				vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
					vim.lsp.buf.format()
				end, { desc = "Format current buffer with LSP" })
			end

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
							on_attach = on_attach,
							settings = servers[server_name],
							filetypes = (servers[server_name] or {}).filetypes,
						})
					end,
				},
			})
		end,
	},
}
