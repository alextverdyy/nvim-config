return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'recent_files', indent = 2, padding = 1 },
        { section = 'projects', indent = 2, padding = 1 },
        { section = 'startup' },
      },
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    lazygit = { enabled = true },
    zen = { enabled = true },
    styles = {
      notification = { wo = { wrap = true } },
    },
  },
  keys = {
    -- Picker
    { '<leader><space>', function() Snacks.picker.smart() end,           desc = 'Smart Find Files' },
    { '<leader>,',       function() Snacks.picker.buffers() end,         desc = 'Buffers' },
    { '<leader>/',       function() Snacks.picker.grep() end,            desc = 'Grep' },
    { '<leader>:',       function() Snacks.picker.command_history() end, desc = 'Command History' },
    { '<leader>sh',      function() Snacks.picker.help() end,            desc = 'Help' },
    { '<leader>sk',      function() Snacks.picker.keymaps() end,         desc = 'Keymaps' },
    { '<leader>s.',      function() Snacks.picker.recent() end,          desc = 'Recent Files' },
    { '<leader>sf',      function() Snacks.picker.files() end,           desc = 'Files' },
    { '<leader>sc',      function() Snacks.picker.colorschemes() end,    desc = 'Colorschemes' },
    { '<leader>s/',      function() Snacks.picker.lines() end,           desc = 'Buffer Lines' },
    { '<leader>fb',      function() Snacks.picker.buffers() end,         desc = 'Buffers' },
    -- LSP pickers
    { 'grd',             function() Snacks.picker.lsp_definitions() end,      desc = 'Goto Definition' },
    { 'grr',             function() Snacks.picker.lsp_references() end,       desc = 'Goto References' },
    { 'gri',             function() Snacks.picker.lsp_implementations() end,  desc = 'Goto Implementation' },
    { 'grt',             function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto Type Definition' },
    { '<leader>ds',      function() Snacks.picker.lsp_symbols() end,          desc = 'Document Symbols' },
    { '<leader>ws',      function() Snacks.picker.lsp_workspace_symbols() end, desc = 'Workspace Symbols' },
    -- Explorer (sidebar)
    { '<leader>E',       function() Snacks.explorer() end, desc = 'File Explorer' },
    -- Lazygit
    { '<leader>g',       function() Snacks.lazygit() end,  desc = 'Lazygit' },
    -- Zen mode
    { '<leader>z',       function() Snacks.zen() end,      desc = 'Zen Mode' },
    -- Notifier history
    { '<leader>sn',      function() Snacks.notifier.show_history() end, desc = 'Notification History' },
    -- Word references (words module)
    { ']]', function() Snacks.words.jump(1) end,  desc = 'Next word reference' },
    { '[[', function() Snacks.words.jump(-1) end, desc = 'Prev word reference' },
    -- Yank history (via picker)
    { '<leader>p', function() Snacks.picker.yanky() end, desc = 'Yank History' },
  },
}
