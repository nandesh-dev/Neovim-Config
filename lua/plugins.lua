local plugins = {
  { 
    'EdenEast/nightfox.nvim',
    config = function()
      require("nightfox").setup()
      vim.cmd.colorscheme "nightfox"
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

      vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)
      vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end)
      vim.keymap.set("n", "<leader>h6", function() harpoon:list():select(6) end)

      vim.keymap.set("n", "<leader>hg", function() harpoon:list():prev() end)
      vim.keymap.set("n", "<leader>hj", function() harpoon:list():next() end)
    
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
          local file_paths = {}
          for _, item in ipairs(harpoon_files.items) do
              table.insert(file_paths, item.value)
          end

          require("telescope.pickers").new({}, {
              prompt_title = "Harpoon",
              finder = require("telescope.finders").new_table({
                  results = file_paths,
              }),
              previewer = conf.file_previewer({}),
              sorter = conf.generic_sorter({}),
          }):find()
      end

      vim.keymap.set("n", "<leader>hw", function() toggle_telescope(harpoon:list()) end,
          { desc = "Open harpoon window" })
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
    }
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {'L3MON4D3/LuaSnip'}
    },
  },
}

return plugins
