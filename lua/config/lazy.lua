-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- NOTE: some plugins that don't require any configuration
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  'rstacruz/vim-closer',
  { "folke/todo-comments.nvim", opts = {} },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',     opts = {} },

  { 'numToStr/Comment.nvim',    opts = {} },
  install = { colorscheme = { "tokyonight" } },

  -- automatically check for plugin updates
  checker = { enabled = true },
  { import = 'plugins' },
})
