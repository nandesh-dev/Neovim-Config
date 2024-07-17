return { 
  'EdenEast/nightfox.nvim',
  config = function()
    require('nightfox').setup({
    options = {
      transparent = true,     -- Disable setting background
    },
})
    vim.cmd.colorscheme "nightfox"
  end
}
