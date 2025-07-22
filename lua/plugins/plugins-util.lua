return {
	-- NOTE: some plugins that don't require any configuration
	-- Detect tabstop and shiftwidth automatically
	{ 'tpope/vim-sleuth' },
	{ 'rstacruz/vim-closer' },
	{ "folke/todo-comments.nvim", opts = {} },

	-- Useful plugin to show you pending keybinds.
	{ 'folke/which-key.nvim',     opts = {} },

	{ 'numToStr/Comment.nvim',    opts = {} },
	-- simple and lightweight plugin to make scrolloff go past the end of the files
	{
		'Aasim-A/scrollEOF.nvim',
		event = { 'CursorMoved', 'WinScrolled' },
		opts = {
			insert_mode = true
		},
	},

}
