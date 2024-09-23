local feline = require("feline")
local rose_pine = require("rose-pine.palette")

local Separator = {
  LEFT = "█",
  MIDDLE = "█",
  RIGHT = "█",
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

local RosePineExtra = {
  MUTED = "muted",
  SUBTLE = "subtle",
  LOVE = "love",
  HIGHLIGHT_LOW = "highlight_low",
  HIGHLIGHT_MED = "highlight_med",
  HIGHLIGHT_HIGH = "highlight_high",
}

local rose_pine_theme = {
  [FelineColor.FG] = rose_pine.text,
  [FelineColor.BG] = rose_pine.surface,
  [FelineColor.BLACK] = rose_pine.base,
  [FelineColor.WHITE] = rose_pine.text,
  [FelineColor.MAGENTA] = rose_pine.iris,
  [FelineColor.ORANGE] = rose_pine.rose,
  [FelineColor.YELLOW] = rose_pine.gold,
  [FelineColor.GREEN] = rose_pine.foam,
  [FelineColor.CYAN] = rose_pine.foam,
  [FelineColor.SKY_BLUE] = rose_pine.foam,
  [FelineColor.OCEAN_BLUE] = rose_pine.pine,
  [FelineColor.VIOLET] = rose_pine.iris,

  -- Colors that aren't part of the default feline theme
  [RosePineExtra.MUTED] = rose_pine.muted,
  [RosePineExtra.SUBTLE] = rose_pine.subtle,
  [RosePineExtra.LOVE] = rose_pine.love,
  [RosePineExtra.HIGHLIGHT_LOW] = rose_pine.highlight_low,
  [RosePineExtra.HIGHLIGHT_MED] = rose_pine.highlight_med,
  [RosePineExtra.HIGHLIGHT_HIGH] = rose_pine.highlight_high,
}

local components = {}

local vi_mode = require("feline.providers.vi_mode")
components.mode_icon = {
  provider = "❯",
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

components.diff_added = {
  provider = git.git_diff_added,
  hl = {
    fg = FelineColor.GREEN,
  },
  enabled = is_git_active,
}

components.diff_removed = {
  provider = git.git_diff_removed,
  hl = {
    fg = RosePineExtra.LOVE,
  },
  enabled = is_git_active,
}

components.diff_changed = {
  provider = git.git_diff_changed,
  hl = {
    fg = FelineColor.YELLOW,
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
    fg = RosePineExtra.LOVE,
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

local cursor = require("feline.providers.cursor")
components.cursor_icon = {
  provider = "",
  hl = {
    fg = FelineColor.BLACK,
    bg = FelineColor.GREEN,
  },
  left_sep = " " .. Separator.LEFT,
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

  components.file_info,
  components.diff_added,
  components.diff_removed,
  components.diff_changed,
}

local right = {
  components.diagnostic_errors,
  components.diagnostic_warnings,
  components.diagnostic_info,
  components.diagnostic_hints,

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
  theme = rose_pine_theme,
  vi_mode_colors = {
    NORMAL = FelineColor.GREEN,
    OP = FelineColor.GREEN,
    INSERT = FelineColor.YELLOW,
    VISUAL = FelineColor.MAGENTA,
    LINES = FelineColor.MAGENTA,
    BLOCK = FelineColor.MAGENTA,
    REPLACE = RosePineExtra.LOVE,
    COMMAND = FelineColor.ORANGE,
  },
})
