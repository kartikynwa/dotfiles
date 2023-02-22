local function telescope_buffers()
  require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({
    sort_lastused = true,
    ignore_current_buffer = true,
  }))
end

local function telesope_file_selector(cwd)
  local opts = {
    previewer = false,
    find_command = { "fd" },
  }
  if cwd ~= nil then
    opts.cwd = cwd
    opts.prompt_title = "Find Files (Git)"
  end
  require("telescope.builtin").find_files(require("telescope.themes").get_dropdown(opts))
end

local function file_selector_smart()
  local git_root = require("lspconfig.util").find_git_ancestor(vim.api.nvim_buf_get_name(0))
  if git_root then
    telesope_file_selector(git_root)
  else
    telesope_file_selector(nil)
  end
end

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- buffer list ignoring current buffer without preview
      {
        "<leader>,",
        telescope_buffers,
        desc = "Buffers",
      },
      -- file selector using git if in a repository otherwise assume cwd to be the root
      {
        "<leader>.",
        file_selector_smart,
        desc = "Find Files (smart)",
      },
      -- same file selector as above but use cwd
      {
        "<leader>>",
        function()
          telesope_file_selector(nil)
        end,
        desc = "Find Files (cwd)",
      },
    },
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
}
