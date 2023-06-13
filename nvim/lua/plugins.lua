vim.cmd [[packadd packer.nvim]]

require("packer").startup(function()
  use 'wbthomason/packer.nvim'
  use "airblade/vim-gitgutter"
  use "nvim-lua/popup.nvim"
  use "kkharji/sqlite.lua"
  use "rcarriga/nvim-notify"
  use "onsails/lspkind-nvim"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lsp-signature-help"
  use "hrsh7th/cmp-nvim-lsp-document-symbol"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-omni"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-calc"
  use "zbirenbaum/copilot-cmp"
  use "f3fora/cmp-spell"
  use "uga-rosa/cmp-dictionary"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-cmdline"
  use "neovim/nvim-lspconfig"
  use { "williamboman/mason.nvim", run = ":MasonUpdate" }
  use "williamboman/mason-lspconfig.nvim"
  use "folke/lsp-colors.nvim"
  use "folke/trouble.nvim"
  use "folke/tokyonight.nvim"
  use "folke/noice.nvim"
  use "folke/edgy.nvim"
  use 'nvim-lualine/lualine.nvim'
  use "j-hui/fidget.nvim"
  use "jose-elias-alvarez/null-ls.nvim"
  use "hrsh7th/vim-vsnip"
  use 'hrsh7th/cmp-vsnip'
  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use "nvim-lua/plenary.nvim"
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-file-browser.nvim"
  use "MunifTanjim/nui.nvim"
  use "nvim-neo-tree/neo-tree.nvim"
  use "mrbjarksen/neo-tree-diagnostics.nvim"
  use "nvim-tree/nvim-web-devicons"
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "Yggdroot/indentLine"
  use "machakann/vim-sandwich"
  use "simeji/winresizer"
  use "vim-jp/vimdoc-ja"
  use "hashivim/vim-terraform"
  use { "akinsho/toggleterm.nvim", tag = '*', config = true }
  use "github/copilot.vim"
  use "simrat39/symbols-outline.nvim"
  use "onsails/lspkind-nvim"
  use "L3MON4D3/LuaSnip"
end)
