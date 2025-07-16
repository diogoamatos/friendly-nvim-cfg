return {
  'nvim-tree/nvim-tree.lua',
  opts = {},
  config = function ()
    vim.keymap.set("n", "<leader>we", "<cmd>NvimTreeFocus<cr>", { desc = "Tree Open"})
    vim.keymap.set("n", "<leader>wt", "<cmd>NvimTreeToggle<cr>", { desc = "Tree Toggle" })
    require("nvim-tree").setup({})
  end
}
