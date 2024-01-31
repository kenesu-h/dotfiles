local ctp_feline = require("catppuccin.groups.integrations.feline")
local feline = require("feline")

local mocha = require("catppuccin.palettes.mocha")

ctp_feline.setup({})

local theme = {
  fg = mocha.text,
  bg = mocha.mantle,
  green = mocha.green,
  yellow = mocha.yellow,
  purple = mocha.mauve,
  orange = mocha.peach,
  peanut = mocha.flamingo,
  red = mocha.maroon,
  aqua = mocha.sky,
  darkblue = mocha.surface0,
  dark_red = mocha.red,
}

local left_sep = " "
local middle_sep = "█"
local right_sep = " "

local components = {}

local vi_mode = require("feline.providers.vi_mode")
components.mode_icon = {
  provider = "",
  hl = function()
    return {
      fg = mocha.surface0,
      bg = vi_mode.get_mode_color(),
    }
  end,
  left_sep = left_sep,
  right_sep = middle_sep,
}
components.mode_body = {
  provider = function()
    return " " .. vi_mode.get_vim_mode()
  end,
  hl = function()
    return {
      fg = vi_mode.get_mode_color(),
      bg = mocha.surface0,
    }
  end,
  right_sep = right_sep,
}

local git = require("feline.providers.git")
local function is_git_active()
  return git.git_branch() ~= ""
end

components.branch_icon = {
  provider = "",
  hl = {
    fg = mocha.surface0,
    bg = mocha.flamingo,
  },
  left_sep = left_sep,
  right_sep = middle_sep,
  enabled = is_git_active,
}

components.branch_body = {
  provider = function()
    return " " .. git.git_branch()
  end,
  hl = {
    fg = mocha.text,
    bg = mocha.surface0,
  },
  enabled = is_git_active,
}

components.diff_added = {
  provider = git.git_diff_added,
  hl = {
    fg = mocha.green,
    bg = mocha.surface0,
  },
  enabled = is_git_active,
}

components.diff_removed = {
  provider = git.git_diff_removed,
  hl = {
    fg = mocha.red,
    bg = mocha.surface0,
  },
  enabled = is_git_active,
}

components.diff_changed = {
  provider = git.git_diff_changed,
  hl = {
    fg = mocha.yellow,
    bg = mocha.surface0,
  },
  right_sep = right_sep,
  enabled = is_git_active,
}

components.file_info = {
  provider = {
    name = "file_info",
    opts = {
      type = "relative-short",
    },
  },
  left_sep = " ",
  right_sep = " ",
}

components.diagnostic_errors = {
  provider = "diagnostic_errors",
  hl = {
    fg = mocha.red,
  },
}

components.diagnostic_warnings = {
  provider = "diagnostic_warnings",
  hl = {
    fg = mocha.yellow,
  },
}

components.diagnostic_hints = {
  provider = "diagnostic_hints",
  hl = {
    fg = mocha.sky,
  },
}

components.diagnostic_info = {
  provider = "diagnostic_info",
  hl = {
    fg = mocha.text,
  },
}

local lsp = require("feline.providers.lsp")
components.lsp_icon = {
  provider = "",
  hl = {
    fg = mocha.surface0,
    bg = mocha.flamingo,
  },
  left_sep = left_sep,
  right_sep = middle_sep,
  enabled = lsp.is_lsp_attached,
}

components.lsp_body = {
  provider = function()
    return " " .. lsp.lsp_client_names()
  end,
  hl = {
    fg = mocha.text,
    bg = mocha.surface0,
  },
  right_sep = right_sep,
  enabled = lsp.is_lsp_attached,
}

local cursor = require("feline.providers.cursor")
components.cursor_icon = {
  provider = "󰈔",
  hl = {
    fg = mocha.surface0,
    bg = mocha.green,
  },
  left_sep = left_sep,
  right_sep = middle_sep,
}

components.cursor_body = {
  provider = function()
    return " " .. cursor.position(nil, {}) .. " " .. cursor.line_percentage(nil, {})
  end,
  hl = {
    fg = mocha.green,
    bg = mocha.surface0,
  },
  right_sep = right_sep,
}

local left = {
  components.mode_icon,
  components.mode_body,

  components.branch_icon,
  components.branch_body,
  components.diff_added,
  components.diff_removed,
  components.diff_changed,

  components.file_info,
  components.diagnostic_errors,
  components.diagnostic_warnings,
  components.diagnostic_info,
  components.diagnostic_hints,
}

local right = {
  components.lsp_icon,
  components.lsp_body,

  components.cursor_icon,
  components.cursor_body,
}

feline.setup({
  components = {
    active = {
      left,
      {},
      right,
    },
    inactive = {
      left,
      {},
      right,
    },
  },
  theme = theme,
  vi_mode_colors = {
    NORMAL = "green",
    OP = "green",
    INSERT = "yellow",
    VISUAL = "purple",
    LINES = "orange",
    BLOCK = "dark_red",
    REPLACE = "red",
    COMMAND = "aqua",
  },
})
