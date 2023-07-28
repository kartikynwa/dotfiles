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

  -- seamless editing of GPG encrypted files
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

  {
    "folke/zen-mode.nvim",
    opts = {
      plugins = {
        window = {
          width = 100,
        },
        alacritty = {
          enabled = true,
        },
      },
    },
  },

  {
    "folke/flash.nvim",
    opts = {
      highlight = {
        groups = {
          match = "Normal",
          current = "Normal",
        },
      },
      modes = {
        search = {
          enabled = false,
        },
        char = {
          enabled = false,
        },
      },
    },
  },
}
