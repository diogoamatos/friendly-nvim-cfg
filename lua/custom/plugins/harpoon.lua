return {
	'theprimeagen/harpoon',
	vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "[A]dd file to Harpoon" }),
	vim.keymap.set("n", "<leader>hs", require("harpoon.ui").toggle_quick_menu, { desc = "[S]how Haroon quick menu" }),
	--	vim.keymap.set("n", "<leader>", function() require("harpoon.ui").nav_file(1) end),
	--	vim.keymap.set("n", "<C-j>", function() require("harpoon.ui").nav_file(2) end),
	vim.keymap.set("n", "<C-j>", function() require("harpoon.ui").nav_next() end),
}
