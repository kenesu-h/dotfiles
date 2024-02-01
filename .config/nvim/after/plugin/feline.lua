local catppuccin = require("catppuccin.palettes.mocha")
local feline = require("feline")

local Separator = {
  LEFT = " ",
  MIDDLE = "█",
  RIGHT = " ",
}

local FelineColor = {
  FG = "fg",
  BG = "bg",
  BLACK = "black",
  WHITE = "white",
  MAGENTA = "magenta",
  ORANGE = "orange",
  YELLOW = "yellow",
  GREEN = "green",
  CYAN = "cyan",
  SKY_BLUE = "skyblue",
  OCEAN_BLUE = "oceanblue",
  VIOLET = "violet",
}

local ExtraColor = {
  ROSEWATER = "rosewater",
  FLAMINGO = "flamingo",
  PINK = "pink",
  RED = "red",
  MAROON = "maroon",
  SAPPHIRE = "sapphire",
}

local theme = {
  [FelineColor.FG] = catppuccin.text,
  [FelineColor.BG] = catppuccin.base,
  [FelineColor.BLACK] = catppuccin.surface0,
  [FelineColor.WHITE] = catppuccin.text,
  [FelineColor.MAGENTA] = catppuccin.mauve,
  [FelineColor.ORANGE] = catppuccin.peach,
  [FelineColor.YELLOW] = catppuccin.yellow,
  [FelineColor.GREEN] = catppuccin.green,
  [FelineColor.CYAN] = catppuccin.teal,
  [FelineColor.SKY_BLUE] = catppuccin.sky,
  [FelineColor.OCEAN_BLUE] = catppuccin.blue,
  [FelineColor.VIOLET] = catppuccin.lavender,

  -- Colors that aren't part of the default feline theme
  [ExtraColor.ROSEWATER] = catppuccin.rosewater,
  [ExtraColor.FLAMINGO] = catppuccin.flamingo,
  [ExtraColor.PINK] = catppuccin.pink,
  [ExtraColor.RED] = catppuccin.red,
  [ExtraColor.MAROON] = catppuccin.maroon,
  [ExtraColor.SAPPHIRE] = catppuccin.sapphire,
}

local components = {}

local vi_mode = require("feline.providers.vi_mode")
components.mode_icon = {
  provider = "",
  hl = function()
    return {
      fg = FelineColor.BLACK,
      bg = vi_mode.get_mode_color(),
    }
  end,
  left_sep = Separator.LEFT,
  right_sep = Separator.MIDDLE,
}
components.mode_body = {
  provider = function()
    return " " .. vi_mode.get_vim_mode()
  end,
  hl = function()
    return {
      fg = vi_mode.get_mode_color(),
      bg = FelineColor.BLACK,
    }
  end,
  right_sep = Separator.RIGHT,
}

local git = require("feline.providers.git")
local function is_git_active()
  return git.git_branch() ~= ""
end

components.branch_icon = {
  provider = "",
  hl = {
    fg = FelineColor.BLACK,
    bg = ExtraColor.PINK,
  },
  left_sep = Separator.LEFT,
  right_sep = Separator.MIDDLE,
  enabled = is_git_active,
}

components.branch_body = {
  provider = function()
    return " " .. git.git_branch()
  end,
  hl = {
    fg = FelineColor.WHITE,
    bg = FelineColor.BLACK,
  },
  enabled = is_git_active,
}

components.diff_added = {
  provider = git.git_diff_added,
  hl = {
    fg = FelineColor.GREEN,
    bg = FelineColor.BLACK,
  },
  enabled = is_git_active,
}

components.diff_removed = {
  provider = git.git_diff_removed,
  hl = {
    fg = ExtraColor.RED,
    bg = FelineColor.BLACK,
  },
  enabled = is_git_active,
}

components.diff_changed = {
  provider = git.git_diff_changed,
  hl = {
    fg = FelineColor.YELLOW,
    bg = FelineColor.BLACK,
  },
  enabled = is_git_active,
}

components.git_right_sep = {
  provider = function()
    return Separator.RIGHT
  end,
  hl = {
    fg = FelineColor.BLACK,
  },
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
    fg = ExtraColor.RED,
  },
}

components.diagnostic_warnings = {
  provider = "diagnostic_warnings",
  hl = {
    fg = FelineColor.YELLOW,
  },
}

components.diagnostic_hints = {
  provider = "diagnostic_hints",
  hl = {
    fg = FelineColor.SKY_BLUE,
  },
}

components.diagnostic_info = {
  provider = "diagnostic_info",
  hl = {
    fg = FelineColor.WHITE,
  },
}

local lsp = require("feline.providers.lsp")
components.lsp_icon = {
  provider = "",
  hl = {
    fg = FelineColor.BLACK,
    bg = ExtraColor.PINK,
  },
  left_sep = Separator.LEFT,
  right_sep = Separator.MIDDLE,
  enabled = lsp.is_lsp_attached,
}

components.lsp_body = {
  provider = function()
    return " " .. lsp.lsp_client_names()
  end,
  hl = {
    fg = FelineColor.WHITE,
    bg = FelineColor.BLACK,
  },
  right_sep = Separator.RIGHT,
  enabled = lsp.is_lsp_attached,
}

local cursor = require("feline.providers.cursor")
components.cursor_icon = {
  provider = "󰈔",
  hl = {
    fg = FelineColor.BLACK,
    bg = FelineColor.GREEN,
  },
  left_sep = Separator.LEFT,
  right_sep = Separator.MIDDLE,
}

components.cursor_body = {
  provider = function()
    return " " .. cursor.position(nil, {}) .. " " .. cursor.line_percentage(nil, {})
  end,
  hl = {
    fg = FelineColor.WHITE,
    bg = FelineColor.BLACK,
  },
  right_sep = Separator.RIGHT,
}

local left = {
  components.mode_icon,
  components.mode_body,

  components.branch_icon,
  components.branch_body,
  components.diff_added,
  components.diff_removed,
  components.diff_changed,
  components.git_right_sep,

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
    NORMAL = FelineColor.GREEN,
    OP = FelineColor.GREEN,
    INSERT = FelineColor.YELLOW,
    VISUAL = FelineColor.MAGENTA,
    LINES = FelineColor.MAGENTA,
    BLOCK = FelineColor.MAGENTA,
    REPLACE = ExtraColor.RED,
    COMMAND = FelineColor.ORANGE,
  },
})
