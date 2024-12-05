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

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Treesitter / LSP
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      local rose_pine = require("rose-pine")
      local ContextColors = {
        TreesitterContext = { bg = rose_pine.overlay },
        TreesitterContextSeparator = { bg = rose_pine.base },
      }

      for hl, col in pairs(ContextColors) do
        vim.api.nvim_set_hl(0, hl, col)
      end

      require("treesitter-context").setup({
        enable = false,
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
        current_line_blame_opts = {
          delay = 0,
        },
      })
    end,
  },

  -- AI Assistance
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_enabled = false
      vim.g.copilot_no_tab_map = true

      vim.keymap.set("i", "<Right>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require("CopilotChat").setup()
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
    "rlane/pounce.nvim",
    config = function()
      local pounce = require("pounce")

      vim.keymap.set({ "n", "v", "o" }, "s", function()
        pounce.pounce({})
        vim.cmd("normal! zz")
      end)
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "sphamba/smear-cursor.nvim",
    opts = {},
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      words = { enabled = true },
    },
  },
  {
    "folke/neodev.nvim",
    opts = {},
  },
})
