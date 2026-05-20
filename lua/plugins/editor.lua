return {
  -- Flash: label-based motion
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { 's',     function() require('flash').jump() end,              mode = { 'n', 'x', 'o' }, desc = 'Flash' },
      { 'S',     function() require('flash').treesitter() end,        mode = { 'n', 'x', 'o' }, desc = 'Flash Treesitter' },
      { 'r',     function() require('flash').remote() end,            mode = 'o',               desc = 'Remote Flash' },
      { 'R',     function() require('flash').treesitter_search() end, mode = { 'o', 'x' },      desc = 'Treesitter Search' },
      { '<c-s>', function() require('flash').toggle() end,            mode = 'c',               desc = 'Toggle Flash Search' },
    },
  },
  -- Harpoon 2: quick file navigation
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>ha', function() require('harpoon'):list():add() end,                                           desc = 'Harpoon: add file' },
      { '<leader>hh', function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end,        desc = 'Harpoon: menu' },
      { '<leader>h1', function() require('harpoon'):list():select(1) end,                                       desc = 'Harpoon: file 1' },
      { '<leader>h2', function() require('harpoon'):list():select(2) end,                                       desc = 'Harpoon: file 2' },
      { '<leader>h3', function() require('harpoon'):list():select(3) end,                                       desc = 'Harpoon: file 3' },
      { '<leader>h4', function() require('harpoon'):list():select(4) end,                                       desc = 'Harpoon: file 4' },
    },
    config = function() end,
  },
  -- Gitsigns: git decorations + hunk operations
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    keys = {
      { '<leader>gb', function() require('gitsigns').blame_line() end, desc = 'Git Blame Line' },
      { '<leader>gp', function() require('gitsigns').preview_hunk() end, desc = 'Git Preview Hunk' },
      { ']h', function() require('gitsigns').next_hunk() end, desc = 'Next Hunk' },
      { '[h', function() require('gitsigns').prev_hunk() end, desc = 'Prev Hunk' },
    },
  },
  -- Diffview: git diff & file history
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>',       desc = 'Diffview Open' },
      { '<leader>gh', '<cmd>DiffviewFileHistory<cr>', desc = 'Diffview File History' },
    },
    opts = {},
  },
  -- Trouble: pretty diagnostics list
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>',                desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',   desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>',        desc = 'Symbols (Trouble)' },
      { '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP Definitions (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>',                    desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>',                     desc = 'Quickfix List (Trouble)' },
    },
    opts = {},
  },
  -- Grug-far: find and replace across files
  {
    'MagicDuck/grug-far.nvim',
    cmd = 'GrugFar',
    keys = {
      { '<leader>sr', '<cmd>GrugFar<cr>', desc = 'Find and Replace (GrugFar)' },
    },
    opts = {},
  },
  -- Persistence: session management
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    keys = {
      { '<leader>qs', function() require('persistence').load() end,                desc = 'Restore Session' },
      { '<leader>qS', function() require('persistence').select() end,              desc = 'Select Session' },
      { '<leader>ql', function() require('persistence').load { last = true } end,  desc = 'Restore Last Session' },
      { '<leader>qd', function() require('persistence').stop() end,                desc = "Don't Save Session" },
    },
  },
  -- Todo-comments: highlight and search TODO/FIXME/etc
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  -- Undotree: visualize undo history
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      { '<leader>u', '<cmd>UndotreeToggle<cr>', desc = 'Toggle Undotree' },
    },
  },
  -- Yanky: yank ring and put improvements
  {
    'gbprod/yanky.nvim',
    event = 'VeryLazy',
    opts = { ring = { storage = 'shada' } },
    keys = {
      { 'y',     '<Plug>(YankyYank)',          mode = { 'n', 'x' }, desc = 'Yank' },
      { 'p',     '<Plug>(YankyPutAfter)',      mode = { 'n', 'x' }, desc = 'Put after' },
      { 'P',     '<Plug>(YankyPutBefore)',     mode = { 'n', 'x' }, desc = 'Put before' },
      { 'gp',    '<Plug>(YankyGPutAfter)',     mode = { 'n', 'x' }, desc = 'G Put after' },
      { 'gP',    '<Plug>(YankyGPutBefore)',    mode = { 'n', 'x' }, desc = 'G Put before' },
      { '<c-p>', '<Plug>(YankyCycleForward)',  desc = 'Cycle yank forward' },
      { '<c-n>', '<Plug>(YankyCycleBackward)', desc = 'Cycle yank backward' },
    },
  },
  -- Which-key: keymap guide
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ', Down = '<Down> ', Left = '<Left> ', Right = '<Right> ',
          C = '<C-…> ', M = '<M-…> ', D = '<D-…> ', S = '<S-…> ',
          CR = '<CR> ', Esc = '<Esc> ', Space = '<Space> ', Tab = '<Tab> ',
        },
      },
      spec = {
        { '<leader>c', group = '[C]ode',      mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>g', group = '[G]it' },
        { '<leader>h', group = '[H]arpoon' },
        { '<leader>q', group = '[Q]uit/Session' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>x', group = '[X] Diagnostics' },
      },
    },
  },
  -- nvim-ufo: better folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async', 'nvim-treesitter/nvim-treesitter' },
    event = 'BufReadPost',
    keys = {
      { 'zR', function() require('ufo').openAllFolds() end,          desc = 'Open all folds' },
      { 'zM', function() require('ufo').closeAllFolds() end,         desc = 'Close all folds' },
      { 'zr', function() require('ufo').openFoldsExceptKinds() end,  desc = 'Open folds except kinds' },
      { 'zm', function() require('ufo').closeFoldsWith() end,        desc = 'Close folds with count' },
      {
        'K',
        function()
          local winid = require('ufo').peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
        desc = 'Peek fold or LSP hover',
      },
    },
    config = function()
      require('ufo').setup {
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = ('   %d lines  '):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              table.insert(newVirtText, { chunkText, chunk[2] })
              break
            end
            curWidth = curWidth + chunkWidth
          end
          table.insert(newVirtText, { suffix, 'MoreMsg' })
          return newVirtText
        end,
        provider_selector = function(_, _, _)
          return { 'treesitter', 'indent' }
        end,
      }
    end,
  },
  -- nvim-bqf: better quickfix
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    opts = {
      auto_enable = true,
      auto_resize_height = true,
    },
  },
  -- Gomove: move lines/blocks
  {
    'booperlv/nvim-gomove',
    event = 'VeryLazy',
    config = function()
      require('gomove').setup {}
    end,
  },
  -- Inc-rename: incremental rename with preview
  {
    'smjonas/inc-rename.nvim',
    cmd = 'IncRename',
    opts = {},
  },
  -- Reactive: cursor/cursorline mode highlights
  {
    'rasulomaroff/reactive.nvim',
    lazy = false,
    config = function()
      require('reactive').setup {
        builtin = { cursorline = true, cursor = true, modemsg = true },
      }
    end,
  },
  -- Window picker
  {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    opts = { filter_rules = { include_current_win = false, autoselect_one = true } },
    keys = {
      {
        '<leader>wp',
        function()
          local win = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(win)
        end,
        desc = 'Pick a window',
      },
    },
  },
}
