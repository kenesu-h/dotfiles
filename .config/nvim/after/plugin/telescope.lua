local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local from_entry = require("telescope.from_entry")
local state = require("telescope.actions.state")
local telescope = require("telescope")

local width = 0.95
local height = 0.95

-- Credits to Telescope devs
local entry_to_qf = function(entry)
  local text = entry.text

  if not text then
    if type(entry.value) == "table" then
      text = entry.value.text
    else
      text = entry.value
    end
  end

  return {
    bufnr = entry.bufnr,
    filename = from_entry.path(entry, false, false),
    lnum = vim.F.if_nil(entry.lnum, 1),
    col = vim.F.if_nil(entry.col, 1),
    text = text,
  }
end

local function remove_selected_from_qflist(prompt_bufnr)
  local selected = state.get_current_picker(prompt_bufnr):get_multi_selection()

  if not next(selected) then
    return
  end

  local qflist = vim.fn.getqflist()
  for _, item in ipairs(selected) do
    for idx, qf_item in ipairs(qflist) do
      if item.bufnr == qf_item.bufnr and item.lnum == qf_item.lnum and item.text == qf_item.text then
        table.remove(qflist, idx)
        break
      end
    end
  end
  vim.fn.setqflist(qflist)
end

telescope.setup({
  defaults = {
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        width = width,
        height = height,
      },
      vertical = {
        width = width,
        height = height,
      },
    },
    mappings = {
      n = {
        -- Modified version of Telescope's `send_selected_to_qf`
        -- Deselects selected items and keeps current prompt open instead of closing it
        ["q"] = function(prompt_bufnr)
          local picker = state.get_current_picker(prompt_bufnr)

          local qf_entries = {}
          for _, entry in ipairs(picker:get_multi_selection()) do
            table.insert(qf_entries, entry_to_qf(entry))
          end

          local prompt = picker:_get_prompt()
          actions.drop_all(prompt_bufnr)

          local qf_title = string.format([[%s (%s)]], picker.prompt_title, prompt)
          vim.fn.setqflist(qf_entries, "a")
          vim.fn.setqflist({}, "a", { title = qf_title })
        end,
      },
    },
  },
  extensions = {
    file_browser = {
      grouped = true,
    },
  },

  pickers = {
    quickfix = {
      mappings = {
        n = {
          ["Q"] = function(prompt_bufnr)
            remove_selected_from_qflist(prompt_bufnr)
            actions.close(prompt_bufnr)
            builtin.quickfix()
          end,
        },
      },
    },
  },
})

telescope.load_extension("file_browser")
