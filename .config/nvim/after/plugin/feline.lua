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

local left_separator = " "
local middle_separator = "█"
local right_separator = " "

local function component_icon(provider, bg, enabled)
  return {
    provider = provider,
    hl = function()
      return {
        fg = mocha.surface0,
        bg = bg(),
      }
    end,
    left_sep = left_separator,
    right_sep = middle_separator,
    enabled = enabled == nil and true or enabled,
  }
end

local function component_body(provider, fg, enabled)
  return {
    provider = function()
      return " " .. provider()
    end,
    hl = function()
      return {
        fg = fg(),
        bg = mocha.surface0,
      }
    end,
    right_sep = right_separator,
    enabled = enabled == nil and true or enabled,
  }
end

local components = {}

local vi_mode = require("feline.providers.vi_mode")
components.mode_icon = component_icon("", vi_mode.get_mode_color)
components.mode_body = component_body(vi_mode.get_vim_mode, vi_mode.get_mode_color)

local git = require("feline.providers.git")
local function git_enabled()
  return git.git_branch() ~= ""
end

components.branch_icon = component_icon("", function()
  return mocha.flamingo
end, git_enabled)
components.branch_body = component_body(git.git_branch, function()
  return mocha.text
end, git_enabled)

components.diff_added = {
  provider = git.git_diff_added,
  hl = {
    fg = mocha.green,
    bg = mocha.mantle,
  },
}

components.diff_removed = {
  provider = git.git_diff_removed,
  hl = {
    fg = mocha.red,
    bg = mocha.mantle,
  },
}

components.diff_changed = {
  provider = git.git_diff_changed,
  hl = {
    fg = mocha.yellow,
    bg = mocha.mantle,
  },
}

local c = {
  separator = {
    provider = "",
  },
  fileinfo = {
    provider = {
      name = "file_info",
      opts = {
        type = "relative-short",
      },
    },
    left_sep = " ",
    right_sep = " ",
  },
  diagnostic_errors = {
    provider = "diagnostic_errors",
    hl = {
      fg = "red",
    },
  },
  diagnostic_warnings = {
    provider = "diagnostic_warnings",
    hl = {
      fg = "yellow",
    },
  },
  diagnostic_hints = {
    provider = "diagnostic_hints",
    hl = {
      fg = "aqua",
    },
  },
  diagnostic_info = {
    provider = "diagnostic_info",
  },
  lsp_client_names = {
    provider = "lsp_client_names",
    hl = {
      fg = "purple",
      bg = "darkblue",
    },
    left_sep = left_separator,
    right_sep = right_separator,
  },
  file_type = {
    provider = {
      name = "file_type",
      opts = {
        filetype_icon = true,
        case = "titlecase",
      },
    },
    hl = {
      fg = "red",
      bg = "darkblue",
    },
    left_sep = left_separator,
    right_sep = right_separator,
  },
  position = {
    provider = "position",
    hl = {
      fg = "green",
      bg = "darkblue",
    },
    left_sep = left_separator,
    right_sep = right_separator,
  },
  line_percentage = {
    provider = "line_percentage",
    hl = {
      fg = "aqua",
      bg = "darkblue",
    },
    left_sep = left_separator,
    right_sep = right_separator,
  },
}

local left = {
  components.mode_icon,
  components.mode_body,

  components.branch_icon,
  components.branch_body,
  components.diff_added,
  components.diff_removed,
  components.diff_changed,
}

local middle = {
  c.fileinfo,
  c.diagnostic_errors,
  c.diagnostic_warnings,
  c.diagnostic_info,
  c.diagnostic_hints,
}

local right = {
  c.lsp_client_names,
  c.file_type,
  c.file_encoding,
  c.position,
  c.line_percentage,
  c.scroll_bar,
}

feline.setup({
  components = {
    active = {
      left,
      middle,
      right,
    },
    inactive = {
      left,
      middle,
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
