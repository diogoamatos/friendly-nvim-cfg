return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	---@module "neo-tree"
	---@type neotree.Config?
	opts = {
	},
	config = function ()
		vim.keymap.set("n", "<leader>n", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neotree"})

		require("neo-tree").setup({
			window = {
				mappings = {
					["<space>"] = { "" },
				}
			},
			filesystem = {
				follow_current_file = {
					enabled = true,
				}
			}
		})
	end
}
