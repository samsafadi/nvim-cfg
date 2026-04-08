-- Enable the faster lua bytecode loader.
vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Require files
require('config.globals')
require('config.pack')
require('config.options')
require('config.autocmd')

-- [[ Configure Treesitter ]]
vim.defer_fn(function()
  local languages = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'regex', 'gdscript', 'godot_resource', 'c_sharp' }
  local ts = require('nvim-treesitter')
  ts.setup({
    install_dir = vim.fn.stdpath('data') .. '/site',
  })

  if vim.fn.executable('tree-sitter') == 1 then
    ts.install(languages)
  end

  vim.api.nvim_create_autocmd('FileType', {
    pattern = languages,
    callback = function(ev)
      pcall(vim.treesitter.start, ev.buf)
      if vim.bo[ev.buf].filetype ~= 'gdscript' then
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })

  require('nvim-treesitter-textobjects').setup({
    select = {
      lookahead = true,
    },
    move = {
      set_jumps = true,
    },
  })

  local select = require('nvim-treesitter-textobjects.select')
  vim.keymap.set({ 'x', 'o' }, 'aa', function() select.select_textobject('@parameter.outer', 'textobjects') end)
  vim.keymap.set({ 'x', 'o' }, 'ia', function() select.select_textobject('@parameter.inner', 'textobjects') end)
  vim.keymap.set({ 'x', 'o' }, 'af', function() select.select_textobject('@function.outer', 'textobjects') end)
  vim.keymap.set({ 'x', 'o' }, 'if', function() select.select_textobject('@function.inner', 'textobjects') end)
  vim.keymap.set({ 'x', 'o' }, 'ac', function() select.select_textobject('@class.outer', 'textobjects') end)
  vim.keymap.set({ 'x', 'o' }, 'ic', function() select.select_textobject('@class.inner', 'textobjects') end)

  local move = require('nvim-treesitter-textobjects.move')
  vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() move.goto_next_start('@function.outer', 'textobjects') end)
  vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@class.outer', 'textobjects') end)
  vim.keymap.set({ 'n', 'x', 'o' }, ']M', function() move.goto_next_end('@function.outer', 'textobjects') end)
  vim.keymap.set({ 'n', 'x', 'o' }, '][', function() move.goto_next_end('@class.outer', 'textobjects') end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() move.goto_previous_start('@function.outer', 'textobjects') end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() move.goto_previous_start('@class.outer', 'textobjects') end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[M', function() move.goto_previous_end('@function.outer', 'textobjects') end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() move.goto_previous_end('@class.outer', 'textobjects') end)

  local swap = require('nvim-treesitter-textobjects.swap')
  vim.keymap.set('n', '<leader>a', function() swap.swap_next('@parameter.inner') end)
  vim.keymap.set('n', '<leader>A', function() swap.swap_previous('@parameter.inner') end)
end, 0)

local gdproject = io.open(vim.fn.getcwd() .. '/project.godot', 'r')
if gdproject then
  io.close(gdproject)
  vim.fn.serverstart './godothost'
end

-- [[ LSP ]]
local servers = {
  ty = {},
  ruff = {
    init_options = {
      settings = {
        ignore = "E501",
      },
    }
  },
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        diagnostics = {
          disable = { 'missing-fields' },
        },
        hint = {
          paramType = { enable = true },
        }
      },
    },
  },
  bashls = {},
  clangd = {},
  terraformls = {},
  gopls = {},
  yamlls = {},
  pico8_ls = {
    filetypes = { 'p8' }
  },
  zls = {
    settings = {
      zig_exe_path = "/usr/local/zig/zig",
      zig_lib_path = "/usr/local/zig/lib"
    },
  },
  ruby_lsp = {
    cmd = { 'env', 'PATH=' .. vim.env.HOME .. '/.rbenv/shims:' .. vim.env.PATH, 'RBENV_VERSION=3.4.7', 'ruby-lsp' },
    filetypes = { 'rb', 'ruby', 'eruby' },
    root_dir = function(fname)
      if type(fname) == 'number' then
        fname = vim.api.nvim_buf_get_name(fname)
      end
      if fname == "" or fname == nil then return nil end
      local root = vim.fs.find({ 'Gemfile', '.git' }, { path = fname, upward = true })[1]
      return root and vim.fs.dirname(root) or nil
    end,
    single_file_support = true,
  },
  ts_ls = {},
  gdscript = {},
  roslyn = {},
}

require('lazydev').setup()
require('mason').setup({
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  },
})

local mason_lspconfig = require('mason-lspconfig')
local capabilities = require('blink-cmp').get_lsp_capabilities()

mason_lspconfig.setup {
  automatic_installation = true,
  ensure_installed = { "ty", "ruff", "lua_ls", "bashls", "clangd", "terraformls", "gopls", "yamlls" },
}

for server_name, server_config in pairs(servers) do
  server_config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_config.capabilities or {})
  vim.lsp.config(server_name, server_config)
  vim.lsp.enable(server_name)
end

-- dap setup
local dap = require('dap')
dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    ---@diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    ---@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
  else
    cb({
      type = 'executable',
      command = '/Users/bassamsafadi/.pyenv/shims/python',
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    })
  end
end

vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

-- MiniSessions configuration
vim.api.nvim_create_user_command('WriteSession',
  function(args)
    if (args['args']) then
      require('mini.sessions').write(args['args'])
    end
  end,
  { desc = 'MiniSessions write new session', nargs = 1 })

vim.api.nvim_create_user_command('DeleteSession', function(args)
    if (args['args']) then
      require('mini.sessions').delete(args['args'])
    end
  end,
  { desc = 'MiniSessions delete session', nargs = 1 })

-- setup keymap last
require('config.keymap')
