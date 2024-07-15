local keymap = vim.keymap

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Nohighlight
keymap.set('n', '<leader>n', ':noh<Return>', { silent = true })

-- Easy buffer movement
keymap.set('n', '<M-,>', ':bprevious<CR>', { silent = true })
keymap.set('n', '<M-.>', ':bnext<CR>', { silent = true })
keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Delete Buffer' })
keymap.set('n', '<leader>b1', ':BufferLineGoToBuffer 1<CR>', { desc = 'Go to buffer 1', silent = true })
keymap.set('n', '<leader>b2', ':BufferLineGoToBuffer 2<CR>', { desc = 'Go to buffer 2', silent = true })
keymap.set('n', '<leader>b3', ':BufferLineGoToBuffer 3<CR>', { desc = 'Go to buffer 3', silent = true })
keymap.set('n', '<leader>b4', ':BufferLineGoToBuffer 4<CR>', { desc = 'Go to buffer 4', silent = true })
keymap.set('n', '<leader>b5', ':BufferLineGoToBuffer 5<CR>', { desc = 'Go to buffer 5', silent = true })
keymap.set('n', '<leader>b6', ':BufferLineGoToBuffer 6<CR>', { desc = 'Go to buffer 6', silent = true })
keymap.set('n', '<leader>b7', ':BufferLineGoToBuffer 7<CR>', { desc = 'Go to buffer 7', silent = true })
keymap.set('n', '<leader>b8', ':BufferLineGoToBuffer 8<CR>', { desc = 'Go to buffer 8', silent = true })
keymap.set('n', '<leader>b9', ':BufferLineGoToBuffer 9<CR>', { desc = 'Go to buffer 9', silent = true })
keymap.set('n', '<leader>b0', ':BufferLineGoToBuffer 10<CR>', { desc = 'Go to buffer 10', silent = true })

-- load keymap
keymap.set('n', '<leader>lk',
  function()
    local config_path = os.getenv('HOME') .. '/.config/nvim/lua/config/keymap.lua'
    dofile(config_path)
  end, { desc = 'Re[l]oad [k]emap'})
-- load options
keymap.set('n', '<leader>lo',
  function()
    local config_path = os.getenv('HOME') .. '/.config/nvim/lua/config/options.lua'
    dofile(config_path)
  end, { desc = 'Re[l]oad [o]ptions'})

-- See `:help telescope.builtin`
keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
keymap.set('n', '<leader>sc', require('telescope.builtin').commands, { desc = '[S]earch [C]ommands' })
keymap.set('n', '<leader>sb', ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = '[S]earch file [B]rowser'})

-- Diagnostic keymaps
keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Neotest keymaps
keymap.set('n', '<leader>tr', ':Neotest run<cr>', { desc = 'Run tests' })
keymap.set('n', '<leader>ts', ':Neotest summary<cr>', { desc = 'Open test summary' })
keymap.set('n', '<leader>to', ':Neotest output<cr>', { desc = 'Show output of tests' })
keymap.set('n', '<leader>tp', ':Neotest output-panel<cr>', { desc = 'Show output panel of tests' })
keymap.set('n', '<leader>tb', ':lua require"dap".toggle_breakpoint()<cr>', { desc = 'toggle_breakpoint' })
keymap.set('n', '<leader>td', ':lua require("neotest").run.run({strategy = "dap"})<cr>', { desc = 'Debug nearest test' })

-- DAP keymaps
keymap.set('n', '<M-i>', function () require("dap").step_into() end, { desc = 'Step into' })
keymap.set('n', '<M-s>', function () require("dap").step_over() end, { desc = 'Step over' })
keymap.set('n', '<M-o>', function () require("dap").step_out() end, { desc = 'Step out' })
keymap.set('n', '<leader>er', function () require("dap").repl.open() end, { desc = 'Open REPL' })
keymap.set('n', '<leader>ec', function () require("dap").continue() end, { desc = 'Continue' })
vim.keymap.set('n', '<Leader>el', function() require('dap').run_last() end, { desc = 'Run last' })

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = '[L]oad', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  ['<leader>b'] = { name = '[B]uffer', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]est', _ = 'which_key_ignore' },
  ['<leader>e'] = { name = 'd[E]bug', _ = 'which_key_ignore' },
}

