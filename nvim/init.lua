-- plugins
require "plugins"

-- defalut
vim.g.mapleader=' '
vim.opt.shiftwidth=4
vim.opt.shiftwidth = 4 
vim.opt.tabstop = 4 
vim.opt.expandtab = true 
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true 
vim.opt.incsearch = true 
vim.opt.number=true
vim.opt.clipboard="unnamedplus"
vim.opt.laststatus = 3
vim.opt.splitkeep = "screen"

vim.cmd[[colorscheme tokyonight-moon]]

-- mason
require("mason").setup()
require("mason-lspconfig").setup()

-- neo-tree
require("neo-tree").setup({
  open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },
})

vim.keymap.set("n", "<C-n>", ":NeoTreeShowToggle", { silent = true })
vim.keymap.set("n", "<leader>n", ":NeoTreeFocus", { silent = true })

-- null-ls
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.actionlint,
      null_ls.builtins.diagnostics.cfn_lint,
    },
})

-- cmp
local status, cmp = pcall(require, "cmp")
if (not status) then return end
local lspkind = require 'lspkind'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
  }
})

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]

-- telescope
local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")
local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end
local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}

telescope.load_extension("file_browser")

vim.keymap.set("n", "<C-p>", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 }
  })
end)

vim.keymap.set('n', '<C-f>', builtin.find_files, {})
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
vim.keymap.set('n', '<C-b>', builtin.buffers, {})

-- noice
require("noice").setup({
  presets = {
    bottom_search = false, 
    command_palette = false,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
})

-- lualine
require('lualine').setup {
  options = {
    theme = 'tokyonight'
  }
}

-- edgy
require("edgy").setup({
  bottom = {
    {
      ft = "toggleterm",
      title = "TERMINAL",
      size = { height = 0.3 },
      filter = function(buf, win)
        return vim.api.nvim_win_get_config(win).relative == ""
      end,
    },
    { ft = "spectre_panel", title = "SPECTRE", size = { height = 0.4 } },
    { ft = "Trouble", title = "TROUBLE" },
    { ft = "qf", title = "QUICKFIX" },
    {
      ft = "help",
      size = { height = 20 },
      -- only show help buffers
      filter = function(buf)
        return vim.bo[buf].buftype == "help"
      end,
    },
  },
  left = {
    {
      title = "  FILE",
      ft = "neo-tree",
      filter = function(buf)
        return vim.b[buf].neo_tree_source == "filesystem"
      end,
      size = { height = 0.7 },
    },
    {
      title = "  GIT",
      ft = "neo-tree",
      filter = function(buf)
        return vim.b[buf].neo_tree_source == "git_status"
      end,
      pinned = true,
      open = "Neotree position=right git_status",
    },
    {
      title = "  BUFFERS",
      ft = "neo-tree",
      filter = function(buf)
        return vim.b[buf].neo_tree_source == "buffers"
      end,
      pinned = true,
      open = "Neotree position=top buffers",
    },
    {
      ft = "裂 DIAGNOSTICS",
      filter = function(buf)
        return vim.b[buf].neo_tree_source == "diagnostics"
      end,
      pinned = true,
      open = "Neotree position=right diagnostics",
    },
    {
      title = "  OUTLINE",
      ft = "Outline",
      pinned = true,
      open = "SymbolsOutline",
    },
    "neo-tree",
  },
})


vim.keymap.set("n", "<leader>e", function()
  require("edgy").toggle()
end, { desc = "Edgy Toggle" })

vim.keymap.set("n", "<leader>E", function()
  require("edgy").select()
end, { desc = "Edgy Select Window" })

-- toggleterm
require("toggleterm").setup()
vim.keymap.set('t', '<C-s>', '<Cmd>exe v:count1 . "ToggleTerm"<CR>', { silent = true })
vim.keymap.set('n', '<C-s>', '<Cmd>exe v:count1 . "ToggleTerm"<CR>', { silent = true })

-- terminal keymap
vim.keymap.set('t', '<C-w>N', '<C-\\><C-n>', {noremap = true})
vim.keymap.set('t', '<C-W>n', '<cmd>new<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><C-N>', '<cmd>new<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>q', '<cmd>quit<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><C-Q>', '<cmd>quit<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>c', '<cmd>close<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>o', '<cmd>only<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><C-O>', '<cmd>only<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><Down>', '<cmd>wincmd j<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><C-J>', '<cmd>wincmd j<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>j', '<cmd>wincmd j<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><Up>', '<cmd>wincmd k<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><C-K>', '<cmd>wincmd k<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>k', '<cmd>wincmd k<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><Left>', '<cmd>wincmd h<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><C-H>', '<cmd>wincmd h<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><BS>', '<cmd>wincmd h<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>h', '<cmd>wincmd h<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><Right>', '<cmd>wincmd l<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><C-L>', '<cmd>wincmd l<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>l', '<cmd>wincmd l<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>w', '<cmd>wincmd w<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><C-W>', '<cmd>wincmd w<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>W', '<cmd>wincmd W<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>t', '<cmd>wincmd t<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><C-T>', '<cmd>wincmd t<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>b', '<cmd>wincmd b<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><C-B>', '<cmd>wincmd b<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>p', '<cmd>wincmd p<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><C-P>', '<cmd>wincmd p<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>P', '<cmd>wincmd P<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>r', '<cmd>wincmd r<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><C-R>', '<cmd>wincmd r<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>R', '<cmd>wincmd R<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>x', '<cmd>wincmd x<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><C-X>', '<cmd>wincmd x<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>K', '<cmd>wincmd K<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>J', '<cmd>wincmd J<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>H', '<cmd>wincmd H<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>L', '<cmd>wincmd L<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>T', '<cmd>wincmd T<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>=', '<cmd>wincmd =<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>-', '<cmd>wincmd -<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>+', '<cmd>wincmd +<CR>', {noremap = true})
vim.keymap.set('t', '<C-W>z', '<cmd>pclose<CR>', {noremap = true})
vim.keymap.set('t', '<C-W><C-Z>', '<cmd>pclose<CR>', {noremap = true})

