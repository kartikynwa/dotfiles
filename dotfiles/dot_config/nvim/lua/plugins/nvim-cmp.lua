return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind.nvim",
    },
    opts = function(_, opts)
      -- Remove the `buffer` nvim-cmp source
      local sources = opts.sources
      for i = #sources, 1, -1 do
        if sources[i].name == "buffer" then
          table.remove(sources, i)
          break
        end
      end

      -- Set up nvim-web-devicons in the cmp UI
      local opts_to_merge = {
        formatting = {
          format = function(entry, vim_item)
            if vim.tbl_contains({ "path" }, entry.source.name) then
              local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
              if icon then
                vim_item.kind = icon
                vim_item.kind_hl_group = hl_group
                return vim_item
              end
            end
            return require("lspkind").cmp_format({ with_text = false })(entry, vim_item)
          end,
        },
      }

      return vim.tbl_deep_extend("force", opts_to_merge, opts or {})
    end,
  },
}
