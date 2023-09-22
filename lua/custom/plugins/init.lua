--") You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {
	vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv"),
	vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv"),
	vim.keymap.set("n", "J", "mzJ`z"),

	-- allows the cursor to stay at the middle of the screen
	-- when moving up and down
	vim.keymap.set("n", "<C-d>", "<C-d>zz"),
	vim.keymap.set("n", "<C-u>", "<C-u>zz"),

	-- allows the search terms to stay at the middle
	vim.keymap.set("n", "n", "nzzzv"),
	vim.keymap.set("n", "N", "nzzzv"),

	-- Allows to paste without losing the previous word buffer
	vim.keymap.set("x", "<leader>p", "\"_dP"),

	vim.keymap.set("n", "Q", "<nop>"),
}
