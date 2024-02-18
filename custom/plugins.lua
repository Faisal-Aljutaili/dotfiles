vim.opt.conceallevel = 2
local plugins = {
  {
    "Faisal-Aljutaili/OpenInPopUp.nvim",
    init = function()
      vim.api.nvim_set_keymap(
        "n",
        "<Leader>go",
        '<cmd>lua require("OpenInPopUp").new{}:open("lazygit", { width = 200, height = 150 })<cr>',
        { noremap = true, silent = true }
      )
    end,
  },
  {
    "Faisal-Aljutaili/laravelTinker.nvim",
    init = function()
      vim.api.nvim_set_keymap(
        "n",
        "<leader>To",
        ':lua require("laravelTinker").open_tinker()<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>Tr",
        ':lua require("laravelTinker").run_laravel_tinker()<CR>',
        { noremap = true, silent = true }
      )
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    -- Lazy load when event occurs. Events are triggered
    -- as mentioned in:
    -- https://vi.stackexchange.com/a/4495/20389
    event = "InsertEnter",
    -- You can also have it load at immediately at
    -- startup by commenting above and uncommenting below:
    -- lazy = false
    opts = {
      suggestion = {
        enabled = true,
        keymap = {
          accept = "<C-y>",
        },
        auto_trigger = true,
      },
    },
  },
  -- {
  --   "nvim-neorg/neorg",
  --   lazy = false,
  --   build = ":Neorg sync-parsers",
  --   -- tag = "*",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("neorg").setup {
  --       load = {
  --         ["core.defaults"] = {},  -- Loads default behaviour
  --         ["core.concealer"] = {}, -- Adds pretty icons to your documents
  --         ["core.dirman"] = {      -- Manages Neorg workspaces
  --           config = {
  --             workspaces = {
  --               notes = "~/neorg/notes",
  --               work = "~/neorg/work",
  --             },
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = false,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },
  {
    "gbprod/yanky.nvim",
    dependencies = { { "kkharji/sqlite.lua", enabled = not jit.os:find "Windows" } },
    opts = {
      highlight = { timer = 250 },
      ring = { storage = jit.os:find "Windows" and "shada" or "sqlite" },
    },
    keys = {
      -- stylua: ignore
      { "<leader>p", function() require("telescope").extensions.yank_history.yank_history({}) end, desc = "Open Yank History" },
      {
        "y",
        "<Plug>(YankyYank)",
        mode = { "n", "x" },
        desc = "Yank text",
      },
      {
        "p",
        "<Plug>(YankyPutAfter)",
        mode = { "n", "x" },
        desc = "Put yanked text after cursor",
      },
      {
        "P",
        "<Plug>(YankyPutBefore)",
        mode = { "n", "x" },
        desc = "Put yanked text before cursor",
      },
      {
        "gp",
        "<Plug>(YankyGPutAfter)",
        mode = { "n", "x" },
        desc = "Put yanked text after selection",
      },
      {
        "gP",
        "<Plug>(YankyGPutBefore)",
        mode = { "n", "x" },
        desc = "Put yanked text before selection",
      },
      {
        "[y",
        "<Plug>(YankyCycleForward)",
        desc = "Cycle forward through yank history",
      },
      {
        "]y",
        "<Plug>(YankyCycleBackward)",
        desc = "Cycle backward through yank history",
      },
      {
        "]p",
        "<Plug>(YankyPutIndentAfterLinewise)",
        desc = "Put indented after cursor (linewise)",
      },
      {
        "[p",
        "<Plug>(YankyPutIndentBeforeLinewise)",
        desc = "Put indented before cursor (linewise)",
      },
      {
        "]P",
        "<Plug>(YankyPutIndentAfterLinewise)",
        desc = "Put indented after cursor (linewise)",
      },
      {
        "[P",
        "<Plug>(YankyPutIndentBeforeLinewise)",
        desc = "Put indented before cursor (linewise)",
      },
      {
        ">p",
        "<Plug>(YankyPutIndentAfterShiftRight)",
        desc = "Put and indent right",
      },
      {
        "<p",
        "<Plug>(YankyPutIndentAfterShiftLeft)",
        desc = "Put and indent left",
      },
      {
        ">P",
        "<Plug>(YankyPutIndentBeforeShiftRight)",
        desc = "Put before and indent right",
      },
      {
        "<P",
        "<Plug>(YankyPutIndentBeforeShiftLeft)",
        desc = "Put before and indent left",
      },
      {
        "=p",
        "<Plug>(YankyPutAfterFilter)",
        desc = "Put after applying a filter",
      },
      {
        "=P",
        "<Plug>(YankyPutBeforeFilter)",
        desc = "Put before applying a filter",
      },
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod",                     lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-b>",
        ["Find Subword Under"] = "<C-b>",
        ["Select Cursor Down"] = "<M-C-Down>",
        ["Select Cursor Up"] = "<M-C-Up>",
      }
    end,
  },
  -- {
  --   "NeogitOrg/neogit",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim", -- required
  --     "sindrets/diffview.nvim", -- optional - Diff integration
  --
  --     "nvim-telescope/telescope.nvim", -- optional
  --   },
  --   config = true,
  --   init = function()
  --     vim.api.nvim_set_keymap("n", "<leader>go", ':lua require("neogit").open()<CR>', { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap(
  --       "n",
  --       "<leader>gc",
  --       ':lua require("neogit").open({ "commit" })<CR>',
  --       { noremap = true, silent = true }
  --     )
  --     vim.api.nvim_set_keymap(
  --       "n",
  --       "<leader>gc",
  --       ':lua require("neogit").open({ cwd = "~" })<CR>',
  --       { noremap = true, silent = true }
  --     )
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
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
        "sqlls",
        "dartls",
        "rust-analyzer",
        "marksman",
      },
    },
  },
  {
    "ccaglak/larago.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    {
      "nvim-lualine/lualine.nvim",
      lazy = false,
      options = { theme = 'gruvbox' },
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = true,
    },
  },
  { "f-person/git-blame.nvim", lazy = false },
  {
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
  },
  {
    "ggandor/leap.nvim",
    lazy = false,
    dependencies = {
      "tpope/vim-repeat",
    },
    config = function()
      require("leap").set_default_keymaps()
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    init = function()
      vim.g.dashboard_custom_header = {}
    end,
    config = function()
      require("dashboard").setup {
        theme = "doom",
        config = {
          header = {
            "",
            -- "                                                    .   \\",
            -- "                                                    :    .",
            -- "                                                    |     .",
            -- "                                                    |      :",
            -- "                                                    |      |",
            -- "                                                    |      |",
            -- "                                                    |      |",
            -- "  ..._  ___                                         |    |",
            -- " `.\"\".\"`''''\"--..___",
            -- ' ,-.  \\             """-...__         _____________/    |',
            -- ' / ` " \'                    `"""""                  .',
            -- " \\                                                      L",
            -- " (>                                                      \\",
            -- "/                                                         \\",
            -- "\\    ___..---.                                            L",
            -- " `--'         '.                                           \\",
            -- "                 .                                           \\_",
            -- "                _/`.                                           `.._",
            -- "             .'     -.                                             `.",
            -- "            /     __.-Y     /''''''-...___,...--------.._            |",
            -- "           /   _.\"    |    /                ' .      \\   '---..._    |",
            -- "          /   /      /    /                _,. '    ,/           |   |",
            -- "          \\_,'     _.'   /              /''     _,-'            _|   |",
            -- "                  '     /               `-----''               /     |",
            -- "                  `...-'     dp                                `...-'",
            "           ▄ ▄                   ",
            "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
            "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
            "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
            "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
            "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
            "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
            "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
            "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
            "|| __     ||",
            "||=\\_`\\=||",
            "|| (__/ ||",
            '||  | | :-"""-.',
            "||==| \\/-=-.   \\",
            "||  |(_|o o/   |_",
            '||   \\/ "  \\   ,_)',
            "||====\\ ^  /__/",
            "||     ;--'  `-.",
            "||    /      .  \\",
            "||===;        \\  \\",
            "||   |         | |",
            "|| .-\\ '     _/_/",
            "|:'  _;.    (_  \\",
            "/  .'  `;\\   \\_/",
            "|_ /      |||  |\\\\",
            "/  _)=====|||  | ||",
            "/  /|      ||/  / //",
            "\\_||      ( `-/ ||",
            "   ||======/  /  \\\\ .-.",
            "   ||      \\_/    \\'-'/",
            '   ||      ||      `"`',
            "   ||======||",
            "   ||      ||",
            "",
            "",
            "",
          },
          center = {
            { icon = "  ", desc = "find word", key = "fw", action = "Telescope live_grep" },
            { icon = "  ", desc = "Find Files", key = "ff", action = "Telescope find_files" },
            { icon = "  ", desc = "Recent Files", key = "fo", action = "Telescope oldfiles" },
            {
              icon = "  ",
              desc = "lazygit",
              key = "go",
              action = ':lua require("OpenInPopUp").new{}:open("lazygit", { width = 200, height = 150 })',
            },
            { icon = "󰒲  ", desc = "Plugins", key = "pl", action = "Lazy" },
            { icon = "⛁  ", desc = "DataBase", key = "db", action = "DBUI" },
            -- { icon = "  ", desc = "tests", key = "to", action = "lua require("neotest").output.open({enter = true})<CR>" },
          },
          footer = {},
          --   "███████╗░█████╗░██╗░██████╗░█████╗░██╗░░░░░      ───▄▄▄       ",
          --   "██╔════╝██╔══██╗██║██╔════╝██╔══██╗██║░░░░░      ─▄▀░▄░▀▄     ",
          --   "█████╗░░███████║██║╚█████╗░███████║██║░░░░░      ─█░█▄▀░█     ",
          --   "██╔══╝░░██╔══██║██║░╚═══██╗██╔══██║██║░░░░░      ─█░▀▄▄▀█▄█▄▀ ",
          --   "██║░░░░░██║░░██║██║██████╔╝██║░░██║███████╗     ▄▄█▄▄▄▄███▀   ",
          --   "╚═╝░░░░░╚═╝░░╚═╝╚═╝╚═════╝░╚═╝░░╚═╝╚══════╝                   ",
          -- },
        },
      }
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  { "jwalton512/vim-blade",    lazy = false },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  {
    "nvim-neotest/neotest",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "theutz/neotest-pest",
      "olimorris/neotest-phpunit",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-pest",
          -- require("neotest-phpunit"),
        },
      }
    end,
    init = function()
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ts",
        ':lua require("neotest").summary.toggle()<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>to",
        ':lua require("neotest").output.open()<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>tO",
        ':lua require("neotest").output.open({enter = true})<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>te",
        ':lua require("neotest").output.enter()<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>tr",
        ':lua require("neotest").run.run()<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>tf",
        ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>',
        { noremap = true, silent = true }
      )
    end,
  },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
  },
}
return plugins
