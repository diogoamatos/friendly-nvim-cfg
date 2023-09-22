return {
	vim.keymap.set("n", "<leader>e",
		vim.cmd.Explore, { desc = "[E]xplorer" }),
	vim.keymap.set("n", "<leader>bd", function()
		vim.cmd.bd();
		vim.cmd.Explore();
	end, { desc = "[B]uffer [D]elete" }),
}
