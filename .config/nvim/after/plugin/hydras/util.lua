--- @module "hydras.util"
local util = {}

local Hydra = require("hydra")
local table_unpack = table.unpack or unpack

--- @param name string
--- @param hint string
--- @param body string?
--- @param heads table<string, any>
--- @return Hydra
function util.base_hydra(name, hint, body, heads)
  return Hydra({
    name = name,
    hint = hint,
    mode = { "n", "v", "o" },
    body = body,
    config = {
      color = "teal",
      invoke_on_body = true,
      hint = {
        position = "middle",
        border = "rounded",
      },
    },
    heads = {
      { "<Esc>", nil, { exit = true, nowait = true } },
      table_unpack(heads),
    },
  })
end

--- @param hydra Hydra
--- @return fun():nil
function util.activator(hydra)
  return function()
    hydra:activate()
  end
end

return util
