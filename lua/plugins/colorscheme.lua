return {
  -- Theme inspired by Atom
  -- 'navarasu/onedark.nvim',
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'tokyonight'
  end,
}
