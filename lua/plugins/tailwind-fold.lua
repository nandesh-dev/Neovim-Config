return {
  'razak17/tailwind-fold.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function ()
    require('tailwind-fold').setup({ft = {'html', 'jsx'}})
  end
}
