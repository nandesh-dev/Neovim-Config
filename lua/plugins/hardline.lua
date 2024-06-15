return{
  'ojroques/nvim-hardline',
  config = function()
    local function my_statusline()
      local opt = {
        indicator_size = 69,
        type_patterns = {'class', 'function', 'method'},
        transform_fn = function(line, _node) return line:gsub('%s*[%[%(%{]*%s*$', '') end,
        separator = ':',
        allow_duplicates = false
      }

      local statusline = require('nvim-treesitter').statusline(opt)
      return statusline
    end
    require('hardline').setup {
      bufferline = false,  -- disable bufferline
      bufferline_settings = {
        exclude_terminal = false,  -- don't show terminal buffers in bufferline
        show_index = false,        -- show buffer indexes (not the actual buffer numbers) in bufferline
      },
      theme = 'default',   -- change theme
      sections = {         -- define sections
        {class = 'mode', item = require('hardline.parts.mode').get_item},
        {class = 'med', item = require('hardline.parts.filename').get_item},
        {class='treesitter-context', item = my_statusline},
        '%<',
        {class = 'med', item = '%='},
        {class = 'low', item = require('hardline.parts.wordcount').get_item, hide = 100},
        {class = 'error', item = require('hardline.parts.lsp').get_error},
        {class = 'warning', item = require('hardline.parts.lsp').get_warning},
        {class = 'high', item = require('hardline.parts.filetype').get_item, hide = 60},
        {class = 'high', item = require('hardline.parts.git').get_item, hide = 100},
      },
    }
  end
}
