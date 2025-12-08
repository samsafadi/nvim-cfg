-- appearance
vim.o.winborder = "single"
vim.o.hlsearch = true
vim.o.number = true
vim.o.relativenumber = true
vim.wo.signcolumn = 'auto'
vim.o.termguicolors = true
vim.cmd.colorscheme('no-clown-fiesta')
vim.opt.background = 'dark'

-- behavior
vim.opt.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.cmdheight = 0
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.conceallevel = 2
vim.o.foldlevel = 99
vim.o.autoread = true
vim.o.splitright = true
vim.o.splitbelow = true

-- neovide
if vim.g.neovide then
  vim.o.guifont = "Fira Code:h14"
  vim.g.neovide_cursor_animation_length = 0
end
