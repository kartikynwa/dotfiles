return {
  -- set Gruvbox as the colorscheme
  "ellisonleao/gruvbox.nvim",
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- will probably move this to a separate file later on
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jsonls = false,
        pyright = {},
      },
    },
  },

  -- use default lualine configuration
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, _)
      return {}
    end,
  },

  -- disable treesitter indent
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      indent = {
        enable = false,
      },
    },
  },

  "jamessan/vim-gnupg",

  {
    "goolord/alpha-nvim",
    opts = {
      section = {
        header = {
          val = {
            [[                                   ]],
            [[  ▐ ▄ ▄▄▄ .       ▌ ▐·▪  • ▌ ▄ ·.  ]],
            [[ •█▌▐█▀▄.▀·▪     ▪█·█▌██ ·██ ▐███▪ ]],
            [[ ▐█▐▐▌▐▀▀▪▄ ▄█▀▄ ▐█▐█•▐█·▐█ ▌▐▌▐█· ]],
            [[ ██▐█▌▐█▄▄▌▐█▌.▐▌ ███ ▐█ ██ ██▌▐█▌ ]],
            [[ ▀▀ █▪ ▀▀▀  ▀█▄▀▪. ▀  ▀▀ ▀▀  █▪▀▀▀ ]],
            [[                                   ]],
            [[                Powered by LazyVim ]],
          },
        },
      },
    },
  },
}
