local plugins = {
  { 
    'EdenEast/nightfox.nvim',
    config = function()
      require("nightfox").setup()
      vim.cmd.colorscheme "nightfox"
    end
  },
  {
    'arnamak/stay-centered.nvim',
    config = function()
      require('stay-centered').setup()
    end
  },
  {
    'ggandor/leap.nvim',
    dependencies = { 'tpope/vim-repeat' },
    config = function()
      vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap)')
      vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
    end
  },
  {
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
  },
  {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
	    require('nvim-treesitter.configs').setup({
        ensure_installed = { "lua", "javascript", "json", "typescript", "ruby" },
        auto_install = true,
        indent = {
          enable = true
        },
        highlight = {
          enable = true
        }
	    })
    end
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon.setup({})

      vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end)
      vim.keymap.set("n", "<leader>hw", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      vim.keymap.set("n", "<leader>hd", function() harpoon:list():remove() end)

      vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)
      vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end)
      vim.keymap.set("n", "<leader>h6", function() harpoon:list():select(6) end)

      vim.keymap.set("n", "<leader>hg", function() harpoon:list():prev() end)
      vim.keymap.set("n", "<leader>hj", function() harpoon:list():next() end) 
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.keymap.set('n', '<leader>t', vim.cmd.NvimTreeToggle)

      local function my_on_attach(bufnr)
        local api = require "nvim-tree.api"

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
      end

      require("nvim-tree").setup {
        on_attach = my_on_attach
      }
    end,
  },
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle)
    end
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
    end
  },
  {'tpope/vim-rails'},
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
     {'hrsh7th/cmp-nvim-lsp'},
    },
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {'L3MON4D3/LuaSnip'}
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' }, -- For vsnip users.
          -- { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = 'buffer' },
        })
      })
    end
  },
  {
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
  },
  {
    'andweeb/presence.nvim',
    config = function()
      require("presence").setup({
      -- General options
      auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
      neovim_image_text   = "Neovim", -- Text displayed when hovered over the Neovim image
      main_image          = "file",                   -- Main image display (either "neovim" or "file")
      log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
      debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
      enable_line_number  = false,                      -- Displays the current line number instead of the current project
      blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
      buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
      file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
      show_time           = true,                       -- Show the timer

      -- Rich Presence text options
      editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
      file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
      git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
      plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
      reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
      workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
      line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
  })
  end
  },
  {
    'windwp/nvim-ts-autotag',
    config = function ()
      require('nvim-ts-autotag').setup({
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
          ["html"] = {
            enable_close = false
          }
        }
      })
    end
  },
  {
    'razak17/tailwind-fold.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function ()
      require('tailwind-fold').setup({ft = {'html', 'jsx'}})
    end
  },
  {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
  }
}

return plugins
