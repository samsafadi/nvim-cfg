local keymap = vim.keymap

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Nohighlight
keymap.set('n', '<leader>ho', ':noh<Return>', { silent = true })

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

-- Picker keymaps
-- Top Pickers & Explorer
Snacks = require('snacks')
keymap.set('n', "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
keymap.set('n', "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
keymap.set('n', "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
keymap.set('n', "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
keymap.set('n', "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })
keymap.set('n', "<leader>e", function() Snacks.explorer() end, { desc = "File Explorer" })
-- find
keymap.set('n', "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
keymap.set('n', "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File" })
keymap.set('n', "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
keymap.set('n', "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })
keymap.set('n', "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
keymap.set('n', "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
-- git
keymap.set('n', "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
keymap.set('n', "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
keymap.set('n', "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
keymap.set('n', "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git Log Line" })
keymap.set('n', "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
keymap.set('n', "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
keymap.set('n', "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
keymap.set('n', "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })
-- Grep
keymap.set('n', "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
keymap.set('n', "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
keymap.set('n', "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
keymap.set({ 'n', 'x' }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word"})
-- search
keymap.set('n', '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
keymap.set('n', '<leader>s/', function() Snacks.picker.search_history() end, { desc = "Search History" })
keymap.set('n', "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
keymap.set('n', "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
keymap.set('n', "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
keymap.set('n', "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
keymap.set('n', "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
keymap.set('n', "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
keymap.set('n', "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
keymap.set('n', "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
keymap.set('n', "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
keymap.set('n', "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
keymap.set('n', "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
keymap.set('n', "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
keymap.set('n', "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
keymap.set('n', "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
keymap.set('n', "<leader>sp", function() Snacks.picker.lazy() end, { desc = "Search for Plugin Spec" })
keymap.set('n', "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
keymap.set('n', "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
keymap.set('n', "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo History" })
keymap.set('n', "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
-- LSP
keymap.set('n', "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
keymap.set('n', "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
keymap.set('n', "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
keymap.set('n', "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
keymap.set('n', "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
keymap.set('n', "gn", function() vim.lsp.buf.rename() end, { desc = "Lsp Rename" })
keymap.set('n', "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
keymap.set('n', "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })

-- Neotest keymaps
keymap.set('n', '<leader>tr', ':Neotest run<cr>', { desc = 'Run tests' })
keymap.set('n', '<leader>ts', ':Neotest summary<cr>', { desc = 'Open test summary' })
keymap.set('n', '<leader>to', ':Neotest output<cr>', { desc = 'Show output of tests' })
keymap.set('n', '<leader>tp', ':Neotest output-panel<cr>', { desc = 'Show output panel of tests' })
keymap.set('n', '<leader>tb', ':lua require"dap".toggle_breakpoint()<cr>', { desc = 'toggle_breakpoint' })
keymap.set('n', '<leader>td', ':lua require("neotest").run.run({strategy = "dap"})<cr>', { desc = 'Debug nearest test' })

-- DAP keymaps
Dap = require('dap')
keymap.set('n', '<M-i>', function () Dap.step_into() end, { desc = 'Step into' })
keymap.set('n', '<M-s>', function () Dap.step_over() end, { desc = 'Step over' })
keymap.set('n', '<M-o>', function () Dap.step_out() end, { desc = 'Step out' })
keymap.set('n', '<leader>pr', function () Dap.repl.open() end, { desc = 'Open REPL' })
keymap.set('n', '<leader>pc', function () Dap.continue() end, { desc = 'Continue' })
keymap.set('n', '<Leader>pl', function() require('dap').run_last() end, { desc = 'Run last' })

-- which-key configuration
local wk = require('which-key')
wk.add({
  { '<leader>b', group = '[B]uffer' },
  { '<leader>l', group = '[L]oad' },
  { '<leader>s', group = '[S]earch'},
  { '<leader>w', group = '[W]orkspace' },
  { '<leader>t', group = '[T]est' },
  { '<leader>g', group = '[G]it' },
})

