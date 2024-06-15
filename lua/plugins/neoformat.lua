return {
  'sbdchd/neoformat',
  config = function()
      vim.cmd('let g:neoformat_enabled_prettier = ["javascript", "typescript", "javascriptreact", "typescriptreact", "css", "json", "scss", "markdown", "html", "lua"]')

      vim.cmd([[
      augroup fmt
        autocmd!
        autocmd BufWritePre * undojoin | Neoformat
      augroup END
      ]])
  end
}
