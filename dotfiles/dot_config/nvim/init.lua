-- DOT_DEST=.config/mpd/mpd.conf
--  _       _ _     _
-- (_)_ __ (_) |_  | |_   _  __ _
-- | | '_ \| | __| | | | | |/ _` |
-- | | | | | | |_ _| | |_| | (_| |
-- |_|_| |_|_|\__(_|_|\__,_|\__,_|
--
--         a config file

-- Based on: https://github.com/nvim-lua/kickstart.nvim
-- Last updated against: fd7f05d872092673ef6a883f72edbf859d268a2e

------------
-- packer --
------------
-- Install packer if it's not already installed

local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })

-- Install plugins
local use = require('packer').use
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager

  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use { -- "gc" to comment visual regions/lines
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  }
  use 'tpope/vim-surround' -- You have been surrounded
  use 'tpope/vim-repeat' -- . works better with this
  use 'ggandor/lightspeed.nvim' -- `f` on 'roids

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
  }

  use 'sainnhe/gruvbox-material' -- THE colorscheme :)

  use { 'feline-nvim/feline.nvim', branch = 'master' } -- Status line

  use 'lukas-reineke/indent-blankline.nvim' -- indent blank lines
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  use 'nvim-treesitter/nvim-treesitter' -- For syntax highlighting I think
  use 'nvim-treesitter/nvim-treesitter-textobjects' -- For tree-sitter I think

  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'williamboman/nvim-lsp-installer' -- Automatically install language servers
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'

  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'saadparwaiz1/cmp_luasnip'

  use 'akinsho/toggleterm.nvim'
end)

--------------------
-- Neovim settings --
--------------------
vim.o.hlsearch = false -- Set highlight on search
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.breakindent = true -- Enable break indent

vim.wo.number = true -- Make line numbers default

vim.cmd [[set undofile]] -- Save undo history

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.gruvbox_material_palette = 'original'
vim.cmd [[colorscheme gruvbox-material]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert'

-- Use global status line
vim.o.laststatus = 3

-- Lua filetype detection
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

-- tabs
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- relative line number
vim.o.relativenumber = true

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- lightspeed.nvim configuration
require('lightspeed').setup {
  jump_to_unique_chars = false,
  safe_labels = {},
}

------------------------
-- Neovim keybindings --
------------------------
-- Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-------------------------------
-- indent-blankline settings --
-------------------------------
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

--------------
-- Gitsigns --
--------------
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

---------------
-- Telescope --
---------------
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          ['<C-j>'] = require('telescope.actions').move_selection_next,
          ['<C-k>'] = require('telescope.actions').move_selection_previous,
        },
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
    },
  },
}

require('telescope').load_extension 'fzf'

-- Add leader shortcuts
vim.keymap.set('n', '<leader><space>', function()
  require('telescope.builtin').buffers(require('telescope.themes').get_dropdown { sort_lastused = true, ignore_current_buffer = true })
end)
vim.keymap.set('n', '<leader>.', function()
  require('telescope.builtin').find_files { previewer = false }
end)
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').grep_string)
vim.keymap.set('n', '<leader>/', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

------------------------
-- lspconfig settings --
------------------------
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
  vim.api.nvim_create_user_command('Format', vim.lsp.buf.formatting, {})
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lsp_opts = {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Enable manually installed LSP servers
-- local servers = { "rust_analyzer" }
local servers = {}
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup(lsp_opts)
end

-- Enable nvim-lsp-installer installed LSP servers
local lsp_installer = require 'nvim-lsp-installer'
lsp_installer.on_server_ready(function(server)
  server:setup(lsp_opts)
end)

------------------------------
-- Treesitter configuration --
------------------------------
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    -- for now, disable indentation since most modules don't support
    enable = false,
    -- disable = { "python" },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-----------------
-- nvim-cmp setup --
-----------------
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- nvim-cmp setup
local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

-----------------
-- feline.nvim --
-----------------

local feline_gruvbox = {
  fg = '#ebdbb2',
  bg = '#32302f',
  black = '#32302f',
  skyblue = '#83a598',
  cyan = '#a89984',
  green = '#98971a',
  oceanblue = '#458588',
  magenta = '#fb4934',
  orange = '#d65d0e',
  red = '#fb4934',
  violet = '#b16286',
  white = '#ebdbb2',
  yellow = '#d79921',
}

local feline = require 'feline'
feline.setup {
  preset = 'noicon',
  theme = feline_gruvbox,
}

-----------------------------------
-- toggleterm.nvim configuration --
-----------------------------------

require('toggleterm').setup {}
local term = require('toggleterm.terminal').Terminal:new {
  dir = 'git_dir',
  direction = 'float',
  float_opts = {
    border = 'double',
  },
}

function _term_toggle()
  term:toggle()
end

vim.keymap.set({ 'n', 't' }, '<C-t>', _term_toggle)

------------------
-- work related --
------------------
vim.cmd [[
  augroup deepql_ft
    autocmd!
    autocmd BufNewFile,BufRead *.deepql set filetype=graphql
  augroup end
]]
