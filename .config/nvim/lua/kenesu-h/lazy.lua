local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        no_italic = true,
        integrations = {
          leap = true,
        },
        custom_highlights = function(colors)
          return {
            CursorLineNr = { fg = colors.green },
            CursorLine = { bg = colors.none },
            TreesitterContext = { bg = colors.crust },
          }
        end,
      })

      vim.cmd.colorscheme("catppuccin-macchiato")
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "nvim-telescope/telescope-ui-select.nvim" },

  -- Treesitter / LSP
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      local colors = require("catppuccin.palettes").get_palette("mocha")
      local ContextColors = {
        TreesitterContextSeparator = { bg = colors.mantle },
      }

      for hl, col in pairs(ContextColors) do
        vim.api.nvim_set_hl(0, hl, col)
      end

      require("treesitter-context").setup({
        separator = "─",
      })
    end,
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
      { "saadparwaiz1/cmp_luasnip" },
    },
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")
      local js_formatters = { "prettier" }

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
    config = function()
      require("gitsigns").setup({
        yadm = {
          enable = true,
        },
      })
    end,
  },
  {
    -- Use this for faster git blames and the ability to open current file's remote URL
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_enabled = false
    end,
  },

  -- Other
  {
    "aserowy/tmux.nvim",
    config = function()
      require("tmux").setup({
        copy_sync = {
          enable = true,
          redirect_to_clipboard = true,
        },
      })
    end,
  },
  { "nvimtools/hydra.nvim" },
  {
    "freddiehaddad/feline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  { "nanozuki/tabby.nvim" },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          {
            sign = { name = { "Diagnostic" }, mawidth = 1, colwidth = 2 },
            click = "v:lua.ScSa",
          },
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
          {
            sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 2 },
            click = "v:lua.ScSa",
          },
        },
      })
    end,
  },
  {
    "mvllow/modes.nvim",
    config = function()
      local catppuccin = require("catppuccin.palettes.mocha")

      require("modes").setup({
        colors = {
          copy = catppuccin.green,
          delete = catppuccin.red,
          insert = catppuccin.peach,
          visual = catppuccin.mauve,
        },

        line_opacity = 0.25,
      })
    end,
  },
  {
    "ggandor/leap.nvim",
    config = function()
      local leap = require("leap")
      leap.add_default_mappings()
      leap.opts.safe_labels = {}

      vim.keymap.set({ "n", "v", "o" }, "s", function()
        leap.leap({ target_windows = { vim.api.nvim_get_current_win() } })
      end)
    end,
  },
  {
    "cbochs/grapple.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        scope = {
          show_start = false,
        },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.comment").setup()
    end,
  },
  {
    "folke/neodev.nvim",
    opts = {},
  },
})
