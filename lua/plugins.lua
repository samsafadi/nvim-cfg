local M = {}

local gh = function(repo)
  return "https://github.com/" .. repo
end

M.specs = {
  gh("tpope/vim-sleuth"),
  gh("neovim/nvim-lspconfig"),
  gh("williamboman/mason.nvim"),
  gh("williamboman/mason-lspconfig.nvim"),
  gh("folke/lazydev.nvim"),
  gh("saghen/blink.cmp"),
  gh("rafamadriz/friendly-snippets"),
  gh("folke/ts-comments.nvim"),
  gh("folke/todo-comments.nvim"),
  gh("nvim-lua/plenary.nvim"),
  gh("folke/which-key.nvim"),
  gh("folke/trouble.nvim"),
  gh("lewis6991/gitsigns.nvim"),
  gh("aktersnurra/no-clown-fiesta.nvim"),
  gh("folke/tokyonight.nvim"),
  gh("nvim-lualine/lualine.nvim"),
  gh("nvim-tree/nvim-web-devicons"),
  gh("numToStr/Comment.nvim"),
  gh("folke/snacks.nvim"),
  gh("stevearc/oil.nvim"),
  gh("echasnovski/mini.icons"),
  gh("echasnovski/mini.nvim"),
  gh("nvim-treesitter/nvim-treesitter"),
  gh("nvim-treesitter/nvim-treesitter-textobjects"),
  gh("vladdoster/remember.nvim"),
  gh("alexghergh/nvim-tmux-navigation"),
  gh("nvim-neotest/neotest"),
  gh("antoinemadec/FixCursorHold.nvim"),
  gh("nvim-neotest/neotest-python"),
  gh("nvim-neotest/nvim-nio"),
  gh("mfussenegger/nvim-dap-python"),
  gh("mfussenegger/nvim-dap"),
  gh("folke/noice.nvim"),
  gh("MunifTanjim/nui.nvim"),
  gh("habamax/vim-godot"),
  gh("seblyng/roslyn.nvim"),
}

function M.setup()
  require("no-clown-fiesta").setup({
    styles = {
      lsp = {
        undercurl = true,
      },
    },
  })

  require("blink.cmp").setup({
    keymap = { preset = "super-tab" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust" },
    cmdline = {
      enabled = true,
    },
    signature = { enabled = true },
    completion = {
      menu = {
        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
      },
      documentation = {},
    },
  })

  if vim.fn.has("nvim-0.10.0") == 1 then
    require("ts-comments").setup()
  end

  require("todo-comments").setup()
  require("which-key").setup({
    preset = "modern",
  })
  require("trouble").setup({})
  require("gitsigns").setup({
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
      vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk, { buffer = bufnr, desc = "Preview git hunk" })

      local gs = package.loaded.gitsigns
      vim.keymap.set({ "n", "v" }, "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
      vim.keymap.set({ "n", "v" }, "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
    end,
  })
  require("lualine").setup({
    options = {
      icons_enabled = false,
      theme = "auto",
      component_separators = { left = "|", right = "|" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        "diff",
        "diagnostics",
        function()
          local reg = vim.fn.reg_recording()
          if reg ~= "" then
            return "Recording @" .. reg
          end
          return ""
        end,
      },
      lualine_c = { "filename" },
      lualine_x = { "searchcount", "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
  })
  require("Comment").setup()
  require("snacks").setup({
    picker = {
      layout = {
        preset = "ivy",
      },
    },
    explorer = { enabled = true },
    notifier = { enabled = true },
    statuscolumn = { enabled = true },
    lazygit = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
      },
    },
  })
  require("oil").setup({})
  require("mini.icons").setup()
  require("mini.pairs").setup()
  require("mini.sessions").setup()
  require("mini.surround").setup()
  require("remember")

  local nvim_tmux_nav = require("nvim-tmux-navigation")
  vim.keymap.set("n", "<M-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
  vim.keymap.set("n", "<M-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
  vim.keymap.set("n", "<M-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
  vim.keymap.set("n", "<M-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
  vim.keymap.set("n", "<M-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
  vim.keymap.set("n", "<M-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

  require("neotest").setup({
    adapters = {
      require("neotest-python")({
        dap = { justMyCode = false },
        args = { "--log-level", "DEBUG" },
        runner = "pytest",
        pytest_discover_instances = true,
      }),
    },
  })

  require("noice").setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
    routes = {
      {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      },
    },
  })
end

return M
