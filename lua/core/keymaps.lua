-- Centralized Neovim Keymaps
-- All keymaps are grouped by feature/plugin for easy maintenance.
-- Each mapping is documented in English for clarity.
--
-- === KEYMAP STRUCTURE DOCUMENTATION ===
--
-- 1. All keymaps for your Neovim config are now defined in this file.
-- 2. Keymaps are grouped by feature/plugin (General, LSP, Terminal, Nvim-tree, Gomove, Window Picker, Ufo, Completion/LuaSnip, Snacks/FZF/Telescope/Flash).
-- 3. Buffer-local keymaps (e.g. LSP, Nvim-tree) are set via exported functions (_G.lsp_keymaps, _G.nvim_tree_keymaps) and called from plugin on_attach hooks.
-- 4. All plugin/config files have been refactored to remove local keymap definitions and reference this file.
-- 5. Each mapping includes a clear English description for easy searching and future updates.
-- 6. To add or change a keymap, simply edit this file and reload your config.
-- 7. If you add a new plugin that needs keymaps, group them here and export any required buffer-local setup functions.
--
-- === END DOCUMENTATION ===

-- =====================
-- General Keymaps
-- =====================
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
-- Diagnostic quickfix list
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- Manual save keymap (Ctrl+S)
vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })
-- Command mode with semicolon
vim.keymap.set('n', ';', ':', { desc = 'Enter command mode' })
vim.keymap.set('v', ';', ':', { desc = 'Enter command mode' })
-- Colon to repeat f/F/t/T motion
vim.keymap.set('n', ':', ';', { desc = 'Repeat f/F/t/T motion' })
-- Incremental rename (IncRename)
vim.keymap.set('n', '<leader>rn', function()
  return ':IncRename ' .. vim.fn.expand '<cword>'
end, { expr = true, desc = 'Incremental Rename' })

-- =====================
-- LSP Keymaps
-- =====================
-- These are buffer-local, set on LspAttach
local function lsp_keymaps(bufnr)
  local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end
  map('<leader>nb', function()
    require 'nvim-navbuddy'.open()
  end, 'Show NavBuddy')
  map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('gra', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
  map('grd', function() require('fzf-lua').lsp_definitions() end, '[G]oto [D]efinition')
  map('grr', function() require('fzf-lua').lsp_references() end, '[G]oto [R]eferences')
  map('gri', function() require('fzf-lua').lsp_implementations() end, '[G]oto [I]mplementation')
  map('grt', function() require('fzf-lua').lsp_typedefs() end, '[G]oto [T]ype Definition')
  map('<leader>ds', function() require('fzf-lua').lsp_document_symbols() end, '[D]ocument [S]ymbols')
  map('<leader>ws', function() require('fzf-lua').lsp_workspace_symbols() end, '[W]orkspace [S]ymbols')
  map('<leader>D', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('<leader>th', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
  end, '[T]oggle Inlay [H]ints')
end
_G.lsp_keymaps = lsp_keymaps -- Export for use in LspAttach

-- =====================
-- Terminal Keymaps
-- =====================
-- Terminal mode escape and navigation
local function set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end
_G.set_terminal_keymaps = set_terminal_keymaps
-- Lazygit toggle
vim.keymap.set('n', '<leader>g', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', { noremap = true, silent = true, desc = 'Lazygit' })

-- =====================
-- Nvim-tree Keymaps
-- =====================
local function nvim_tree_keymaps(bufnr)
  local api = require 'nvim-tree.api'
  local function edit_or_open()
    local node = api.tree.get_node_under_cursor()
    if node.nodes ~= nil then
      api.node.open.edit()
    else
      api.node.open.edit()
      api.tree.close()
    end
  end
  local function vsplit_preview()
    local node = api.tree.get_node_under_cursor()
    if node.nodes ~= nil then
      api.node.open.edit()
    else
      api.node.open.vertical()
    end
    api.tree.focus()
  end
  local function opts(desc)
    return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  vim.keymap.set('n', 'l', edit_or_open, opts('Edit Or Open'))
  vim.keymap.set('n', 'L', vsplit_preview, opts('Vsplit Preview'))
  vim.keymap.set('n', 'h', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'H', api.tree.collapse_all, opts('Collapse All'))
  vim.keymap.set('n', '<CR>', edit_or_open, opts('Edit Or Open'))
  vim.keymap.set('n', 'o', edit_or_open, opts('Edit Or Open'))
end
_G.nvim_tree_keymaps = nvim_tree_keymaps
-- Toggle nvim-tree
vim.keymap.set('n', '<leader>e', function()
  local api = require 'nvim-tree.api'
  api.tree.toggle { path = '<args>', find_file = true, update_root = false, focus = true }
end, { silent = true, noremap = true, desc = 'Tree' })

-- =====================
-- Gomove Keymaps
-- =====================
local directions = { h = 'Left', j = 'Down', k = 'Up', l = 'Right' }
local gomove_opts = { silent = true, noremap = true }
for key, dir in pairs(directions) do
  vim.keymap.set('n', '<S-' .. key .. '>', '<Plug>GoNSM' .. dir,
    vim.tbl_extend('force', gomove_opts, { desc = 'GoMove: Smart Move ' .. dir .. ' (Normal)' }))
  vim.keymap.set('x', '<S-' .. key .. '>', '<Plug>GoVSM' .. dir,
    vim.tbl_extend('force', gomove_opts, { desc = 'GoMove: Smart Move ' .. dir .. ' (Visual)' }))
  vim.keymap.set('n', '<C-' .. key .. '>', '<Plug>GoNSD' .. dir,
    vim.tbl_extend('force', gomove_opts, { desc = 'GoMove: Smart Duplicate ' .. dir .. ' (Normal)' }))
  vim.keymap.set('x', '<C-' .. key .. '>', '<Plug>GoVSD' .. dir,
    vim.tbl_extend('force', gomove_opts, { desc = 'GoMove: Smart Duplicate ' .. dir .. ' (Visual)' }))
end

-- =====================
-- Window Picker Keymaps
-- =====================
vim.keymap.set('n', '<leader>wp', function()
  local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end, { desc = 'Pick a window' })

-- =====================
-- Ufo (Folding) Keymaps
-- =====================
vim.keymap.set('n', 'zR', function() require('ufo').openAllFolds() end, { desc = 'Open all folds' })
vim.keymap.set('n', 'zM', function() require('ufo').closeAllFolds() end, { desc = 'Close all folds' })
vim.keymap.set('n', 'zr', function() require('ufo').openFoldsExceptKinds() end,
  { desc = 'Open folds except specified kinds' })
vim.keymap.set('n', 'zm', function() require('ufo').closeFoldsWith() end, { desc = 'Close folds with specified kinds' })
vim.keymap.set('n', 'K', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = 'Peek fold or LSP hover' })

-- =====================
-- Completion/LuaSnip Keymaps
-- =====================
vim.keymap.set({ 'i', 's' }, '<C-l>', function()
  require('luasnip').jump(1)
end, { desc = 'LuaSnip: Jump forward' })
vim.keymap.set({ 'i', 's' }, '<C-h>', function()
  require('luasnip').jump(-1)
end, { desc = 'LuaSnip: Jump backward' })

-- =====================
-- Snacks/FZF/Telescope/Flash Keymaps
-- =====================
-- Example: Snacks pickers (can be migrated to fzf-lua/telescope as needed)
vim.keymap.set('n', '<leader><space>', function() require('fzf-lua').files() end, { desc = 'Smart Find Files' })
vim.keymap.set('n', '<leader>,', function() require('fzf-lua').buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>/', function() require('fzf-lua').live_grep() end, { desc = 'Grep' })
vim.keymap.set('n', '<leader>:', function() require('fzf-lua').command_history() end, { desc = 'Command History' })
vim.keymap.set('n', '<leader>fb', function() require('fzf-lua').buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>sh', function() require('fzf-lua').help_tags() end, { desc = 'Help' })
vim.keymap.set('n', '<leader>sk', function() require('fzf-lua').keymaps() end, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>s.', function() require('fzf-lua').oldfiles() end, { desc = 'Recent files' })
vim.keymap.set('n', '<leader>sf', function() require('fzf-lua').files() end, { desc = 'Files' })
vim.keymap.set('n', '<leader>sc', function() require('fzf-lua').colorschemes() end, { desc = 'Colorschemes' })
vim.keymap.set('n', '<leader>s/', function() require('fzf-lua').lines() end, { desc = 'Lines' })

-- Flash navigation
vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end, { desc = 'Flash' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })
vim.keymap.set('o', 'r', function() require('flash').remote() end, { desc = 'Remote Flash' })
vim.keymap.set({ 'o', 'x' }, 'R', function() require('flash').treesitter_search() end, { desc = 'Treesitter Search' })
vim.keymap.set('c', '<c-s>', function() require('flash').toggle() end, { desc = 'Toggle Flash Search' })

-- =====================
-- iOS Development Keymaps (macOS only)
-- =====================
if vim.loop.os_uname().sysname == 'Darwin' then
  -- iOS/Xcodebuild keymaps
  -- These keymaps provide build, run, test, clean, device/scheme selection, and picker commands for Xcode projects.
  -- Prefix: <leader>x
  vim.keymap.set('n', '<leader>x', '', { desc = '📱 iOS Development' })
  vim.keymap.set('n', '<leader>xp', '<cmd>XcodebuildPicker<cr>', { desc = 'Show picker' })
  vim.keymap.set('n', '<leader>xb', '<cmd>XcodebuildBuild<cr>', { desc = 'Build project' })
  vim.keymap.set('n', '<leader>xr', '<cmd>XcodebuildRun<cr>', { desc = 'Run project' })
  vim.keymap.set('n', '<leader>xt', '<cmd>XcodebuildTest<cr>', { desc = 'Run tests' })
  vim.keymap.set('n', '<leader>xc', '<cmd>XcodebuildClean<cr>', { desc = 'Clean build' })
  vim.keymap.set('n', '<leader>xs', '<cmd>XcodebuildSelectScheme<cr>', { desc = 'Select scheme' })
  vim.keymap.set('n', '<leader>xd', '<cmd>XcodebuildSelectDevice<cr>', { desc = 'Select device' })
  vim.keymap.set('n', '<leader>xq', '<cmd>XcodebuildQuickfix<cr>', { desc = 'Show quickfix' })

  -- iOS Project/Task keymaps
  -- Prefix: <leader>fp for project picker, <leader>o for tasks
  vim.keymap.set('n', '<leader>fp', function() require('fzf-lua').projects() end, { desc = 'Find projects (fzf-lua)' })
  vim.keymap.set('n', '<leader>o', '', { desc = '⚙️  Tasks' })
  vim.keymap.set('n', '<leader>or', '<cmd>OverseerRun<cr>', { desc = 'Run task' })
  vim.keymap.set('n', '<leader>ot', '<cmd>OverseerToggle<cr>', { desc = 'Toggle tasks' })
  vim.keymap.set('n', '<leader>oa', '<cmd>OverseerTaskAction<cr>', { desc = 'Task actions' })
  vim.keymap.set('n', '<leader>oi', '<cmd>OverseerInfo<cr>', { desc = 'Task info' })
  vim.keymap.set('n', '<leader>ob', '<cmd>OverseerBuild<cr>', { desc = 'Build task' })
  vim.keymap.set('n', '<leader>oq', '<cmd>OverseerQuickAction<cr>', { desc = 'Quick action' })

  -- Swift Debugging keymaps
  -- Prefix: <leader>d
  vim.keymap.set('n', '<leader>d', '', { desc = '🐛 Debug' })
  vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end, { desc = 'Toggle breakpoint' })
  vim.keymap.set('n', '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
    { desc = 'Conditional breakpoint' })
  vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { desc = 'Continue' })
  vim.keymap.set('n', '<leader>dn', function() require('dap').step_over() end, { desc = 'Step over' })
  vim.keymap.set('n', '<leader>ds', function() require('dap').step_into() end, { desc = 'Step into' })
  vim.keymap.set('n', '<leader>do', function() require('dap').step_out() end, { desc = 'Step out' })
  vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end, { desc = 'Open REPL' })
  vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end, { desc = 'Run last' })
  vim.keymap.set('n', '<leader>du', function() require('dapui').toggle() end, { desc = 'Toggle UI' })
  vim.keymap.set('n', '<leader>dq', function() require('dap').terminate() end, { desc = 'Quit debug session' })

  -- Documentation:
  -- These keymaps and plugins provide a full iOS development workflow in Neovim on macOS:
  -- - Build, run, test, and clean Xcode projects
  -- - Select devices and schemes
  -- - Manage iOS projects and tasks
  -- - Debug Swift code with DAP
  -- All features are only available on macOS.
end

-- =====================
-- CodeCompanion Keymaps
-- =====================
-- These keymaps provide quick access to CodeCompanion AI features in normal and visual mode.
local codecompanion_icon = '🤖 '
vim.keymap.set('n', '<leader>A', '', { desc = codecompanion_icon .. 'CodeCompanion' })
vim.keymap.set('v', '<leader>A', '', { desc = codecompanion_icon .. 'CodeCompanion' })
vim.keymap.set('n', '<leader>Ac', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle chat' })
vim.keymap.set('v', '<leader>Ac', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle chat' })
vim.keymap.set('n', '<leader>Aa', '<cmd>CodeCompanionActions<cr>', { desc = 'Actions' })
vim.keymap.set('v', '<leader>Aa', '<cmd>CodeCompanionActions<cr>', { desc = 'Actions' })

-- Surround Keymaps (mini.surround)
-- =====================
-- Prefix: gz
vim.keymap.set({ 'n', 'v' }, 'gza', function() require('mini.surround').add() end, { desc = 'Add surrounding' })
vim.keymap.set('n', 'gzd', function() require('mini.surround').delete() end, { desc = 'Delete surrounding' })
vim.keymap.set('n', 'gzf', function() require('mini.surround').find() end, { desc = 'Find right surrounding' })
vim.keymap.set('n', 'gzF', function() require('mini.surround').find_left() end, { desc = 'Find left surrounding' })
vim.keymap.set('n', 'gzh', function() require('mini.surround').highlight() end, { desc = 'Highlight surrounding' })
vim.keymap.set('n', 'gzr', function() require('mini.surround').replace() end, { desc = 'Replace surrounding' })
vim.keymap.set('n', 'gzn', function() require('mini.surround').update_n_lines() end, { desc = 'Update n_lines' })

-- =====================
-- Bufdelete Keymaps
-- =====================
vim.keymap.set('n', '<leader>bd', '<cmd>Bdelete<cr>', { desc = 'Delete buffer (bufdelete)' })
vim.keymap.set('n', '<leader>bD', '<cmd>Bwipeout<cr>', { desc = 'Wipeout buffer (bufdelete)' })

-- Git Blame
vim.keymap.set('n', '<leader>gb', function() require('gitsigns').blame_line() end, { desc = 'Git Blame Line' })

-- End of centralized keymaps
-- =====================
