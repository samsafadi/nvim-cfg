-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make relative line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = 'auto'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
vim.opt.hlsearch = true

-- hide command line
vim.o.cmdheight = 0

-- tab size
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
vim.opt.background = 'dark'
vim.cmd.colorscheme('no-clown-fiesta')

-- neorg
vim.o.conceallevel = 2
vim.o.foldlevel = 99

-- autoread
vim.o.autoread = true
