-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        styles = {
          bold = false,
          italic = false,
          transparency = true,
        },
        highlight_groups = {
          CursorLineNr = { fg = "foam" },
          CursorLine = { bg = "none" },
        },
      })

      vim.cmd.colorscheme("rose-pine")
    end,
  },

  -- File Explorer
  {
    "stevearc/oil.nvim",
    tag = "v2.15.0",
    opts = {
      watch_for_changes = true,
    },
  },

  -- Snacks
  {
    "folke/snacks.nvim",
    tag = "v2.22.0",
    priority = 1000,
    event = "BufReadPre",
    opts = {
      picker = { enabled = true },
      rename = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- Configured in treesitter.lua
  },

  -- LSP
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      { "rafamadriz/friendly-snippets" },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "saadparwaiz1/cmp_luasnip" },
    },
  },
  -- All configured in lsp.lua

  -- Diagnostics
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    priority = 1000,
    event = "BufReadPre",
    opts = {
      preset = "powerline",
      options = {
        show_source = true,
        enable_on_insert = true,
      },
    },
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    event = "BufReadPre",
    config = function()
      local conform = require("conform")
      local js_formatters = { "eslint" }

      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = js_formatters,
          javascriptreact = js_formatters,
          typescript = js_formatters,
          typescriptreact = js_formatters,
        },
        format_after_save = {},
      })
    end,
  },

  -- Linter
  {
    "mfussenegger/nvim-lint",
    event = "BufReadPre",
    config = function()
      local lint = require("lint")
      local js_linters = { "eslint" }

      lint.linters_by_ft = {
        lua = { "luacheck" },
        python = { "mypy", "flake8" },
        javascript = js_linters,
        javascriptreact = js_linters,
        typescript = js_linters,
        typescriptreact = js_linters,
      }

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
        callback = function()
          lint.try_lint(nil, { ignore_errors = true })
        end,
      })
    end,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "purarue/gitsigns-yadm.nvim",
        opts = {
          shell_timeout_ms = 1000,
        },
      },
    },
    opts = {
      _on_attach_pre = function(_, callback)
        require("gitsigns-yadm").yadm_signs(callback)
      end,
      current_line_blame_opts = {
        delay = 0,
      },
    },
  },

  -- Refactoring
  {
    "MagicDuck/grug-far.nvim",
    event = "VeryLazy",
    opts = {
      keymaps = {
        replace = { n = "<leader><C-e>" },
        openLocation = { n = "<leader><C-o>" },
        refresh = { n = "<leader><C-r>" },
        help = { n = "g?" },

        qflist = false,
        syncLocations = false,
        syncLine = false,
        close = false,
        historyOpen = false,
        historyAdd = false,
        openNextLocation = false,
        openPrevLocation = false,
        gotoLocation = false,
        pickHistoryEntry = false,
        abort = false,
        toggleShowCommand = false,
        swapEngine = false,
        previewLocation = false,
        swapReplacementInterpreter = false,
        applyNext = false,
        applyPrev = false,
      },
    },
  },

  -- AI Assistance
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_enabled = true
      vim.g.copilot_no_tab_map = true

      vim.keymap.set("i", "<Right>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
    end,
  },

  -- Other
  {
    "aserowy/tmux.nvim",
    event = "VeryLazy",
    opts = {
      copy_sync = {
        enable = true,
        redirect_to_clipboard = true,
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
  },
  {
    "freddiehaddad/feline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  { "nanozuki/tabby.nvim" },
  {
    "lukas-reineke/virt-column.nvim",
    event = "BufReadPre",
    opts = {},
  },
  {
    "rlane/pounce.nvim",
    event = "BufReadPre",
    config = function()
      local pounce = require("pounce")

      vim.keymap.set({ "n", "v", "o" }, "s", function()
        pounce.pounce({})
        vim.cmd("normal! zz")
      end, {
        noremap = true,
        silent = true,
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    event = "VeryLazy",
    opts = {},
  },
})
