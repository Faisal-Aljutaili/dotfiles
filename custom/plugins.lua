local plugins = {
{
  "neovim/nvim-lspconfig",
   config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
   end,
},{
   "williamboman/mason.nvim",
   opts = {
      ensure_installed = {
        "eslint-lsp",
        "lua-language-server",
        "jedi-language-server",
        "intelephense",
          "docker-compose-language-service",
      "dockerfile-language-server",
        "html-lsp",
        "prettier",
        "css-lsp",
        "stylua",
        "sqlls"
      },
    },
  },{
    'ccaglak/larago.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim"
    }, {
	"nvim-lualine/lualine.nvim",
  lazy  = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = true,
}
},{'f-person/git-blame.nvim',lazy = false
},{
  "neovim/nvim-lspconfig",

   dependencies = {
     "jose-elias-alvarez/null-ls.nvim",
     config = function()
       require "custom.configs.null-ls"
     end,
   },
   config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
   end,
},{
    "ggandor/leap.nvim",lazy = false, dependencies = {
      'tpope/vim-repeat'
    },
    config = function() require("leap").set_default_keymaps() end
},{
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      -- config
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
},{
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
},{"jwalton512/vim-blade", lazy=false},{
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts) require'lsp_signature'.setup(opts) end
},
{
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "theutz/neotest-pest",
    "olimorris/neotest-phpunit"
  },
   config = function()
    require("neotest").setup({
      adapters = {
       require("neotest-pest"),
       require("neotest-phpunit"),
      }
    })
  end,
  init = function ()
   vim.api.nvim_set_keymap('n', '<leader>ts', ':lua require("neotest").summary.toggle()<CR>', { noremap = true, silent = true })
   vim.api.nvim_set_keymap('n', '<leader>to', ':lua require("neotest").output.open()<CR>', { noremap = true, silent = true })
   vim.api.nvim_set_keymap('n', '<leader>tO', ':lua require("neotest").output.open({enter = true})<CR>', { noremap = true, silent = true })
   vim.api.nvim_set_keymap('n', '<leader>te', ':lua require("neotest").output.enter()<CR>', { noremap = true, silent = true })
   vim.api.nvim_set_keymap('n', '<leader>tr', ':lua require("neotest").run.run()<CR>', { noremap = true, silent = true })
   vim.api.nvim_set_keymap('n', '<leader>tf', ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { noremap = true, silent = true })
  end
}
}
return plugins
