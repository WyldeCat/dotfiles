return {
  { "github/copilot.vim", lazy = false },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
    },
  },
  {
    "anuvyklack/windows.nvim",
    lazy = false,
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup()
      vim.cmd("WindowsDisableAutowidth")
    end,
    keys = {
      {
        "<leader>m",
        function()
          vim.cmd('WindowsMaximize')
        end,
        desc = "Maximize current window",
      },
      {
        "<leader>v",
        function()
          vim.cmd('WindowsMaximizeVertically')
        end,
        desc = "Maximize current window vertically",
      },
      {
        "<leader>h",
        function()
          vim.cmd('WindowsMaximizeHorizontally')
        end,
        desc = "Maximize current window horizontally",
      },
      {
        "<leader>e",
        function()
          vim.cmd('WindowsEqualize')
        end,
        desc = "Equalize window sizes",
      },
      {
        "<leader>a",
        function()
          vim.cmd('WindowsToggleAutowidth')
        end,
        desc = "Toggle autowidth",
      },
    },
  },
  {
    "anuvyklack/middleclass",
    lazy = false
  },
  {
    "anuvyklack/animation.nvim",
    lazy = false
  },
  {
    "mfussenegger/nvim-lint",
    lazy = false,
    config = function()
      require('lint').linters_by_ft = {
        python = {'ruff'},
      }
    end
  },
  {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = {
            "ruff_fix",          -- 자동 수정
            "isort",
          }
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
    end
  },
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    opts = {}
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged_enable = true,
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true
        },
        auto_attach = true,
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
      })
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = false,
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
        -- default window options

    },
    event = "VeryLazy",
    keys = {
      -- Chat with Copilot in visual mode
      {
        "<leader>cv",
        function(args)
          require("CopilotChat").open({
            window = {
              layout = "vertical",
              width = 0.2,
              height = 1,
            }
          })
        end,
        desc = "CopilotChat - Open in vertical split",
      },
      {
        "<leader>cf",
        function(args)
          require("CopilotChat").open({
            window = {
              layout = "float",
              width = 0.5,
              height = 0.5,
            }
          })
        end,
        desc = "CopilotChat - Open in floating window",
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = true })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }
}
