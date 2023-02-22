---@type string[]
local _disabled_plugins = {
  "folke/noice.nvim",
  "SmiteshP/nvim-navic",
  "stevearc/dressing.nvim",
  "windwp/nvim-spectre",
  "echasnovski/mini.indentscope",
  "echasnovski/mini.pairs",
}

---@type table<string, any>
local disabled_plugins = {}
for i, plugin in ipairs(_disabled_plugins) do
  disabled_plugins[i] = {
    plugin,
    enabled = false,
  }
end

return disabled_plugins
