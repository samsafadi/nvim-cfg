-- Enable the faster lua bytecode loader.
vim.loader.enable()

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Require files
require('config.globals')
require('config.lazy')
require('config.options')
require('config.autocmd')

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'regex' },
    ignore_install = {},
    modules = {},

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    -- Sync installs
    sync_install = true,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
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
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

local capabilities = require('blink-cmp').get_lsp_capabilities()

-- Setup neovim lua configuration
require('lazydev').setup()

require('mason').setup()
local mason_lspconfig = require('mason-lspconfig')

local servers = {
  basedpyright = {
    settings = {
      basedpyright = {
        disableOrganizeImports = true,
        analysis = {
          typeCheckingMode = "off",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
          exclude = {
            ".tox",
            ".venv",
            "venv",
            "**/__pycache__",
            "**/node_modules",
            "**/build",
            "**/dist",
          }
        },
      },
      python = {
        analysis = {
          ignore = "*",
        }
      }
    },
  },
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
  ts_ls = {},
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
}

mason_lspconfig.setup {
  automatic_installation = true,
  ensure_installed = { "basedpyright", "ruff", "lua_ls", "bashls", "clangd", "terraformls", "gopls", "yamlls" },
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
