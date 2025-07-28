return {
  -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 0,
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = false,
      group = '',
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table,
      colors = true,
      keys = {
        Up = ' ',
        Down = ' ',
        Left = ' ',
        Right = ' ',
        C = '󰘴 ',
        M = '󰘵 ',
        D = '󰘳 ',
        S = '󰘶 ',
        CR = '󰌑 ',
        Esc = '󱊷 ',
        ScrollWheelDown = '󱕐 ',
        ScrollWheelUp = '󱕑 ',
        NL = '󰌑 ',
        BS = '󰁮',
        Space = '󱁐 ',
        Tab = '󰌒 ',
        F1 = '󱊫',
        F2 = '󱊬',
        F3 = '󱊭',
        F4 = '󱊮',
        F5 = '󱊯',
        F6 = '󱊰',
        F7 = '󱊱',
        F8 = '󱊲',
        F9 = '󱊳',
        F10 = '󱊴',
        F11 = '󱊵',
        F12 = '󱊶',
      },
    },

    -- Document existing key chains
    spec = {
      -- Search group
      { '<leader>s', group = '󰍉 [S]earch' },

      -- Util group
      { '<leader>u', group = '󰒓 [U]til' },

      -- Toggle group
      { '<leader>t', group = '󰔡 [T]oggle' },

      -- Harpoon group
      { '<leader><leader>', group = '󱡀 Harpoon' },

      -- Git Hunk group
      { '<leader>h', group = '󰊢 Git [H]unk', mode = { 'n', 'v' } },

      -- Git group
      { '<leader>g', group = '󰊢 [G]it', mode = { 'n', 'v' } },

      -- Individual key mappings with icons
      -- File operations
      { '<leader>e', desc = '󰙅 File Explorer' },
      { '<leader>f', desc = '󰈙 [F]ormat buffer' },
      { '<leader>,', desc = '󰸩 Buffers' },
      { '<leader>.', desc = '󰠮 Toggle Scratch Buffer' },
      { '<leader>:', desc = '󰘳 Command History' },
      { '<leader>/', desc = '󰍉 [/] Fuzzily search in current buffer' },
      { '<leader>n', desc = '󰎟 Notification History' },
      { '<leader>N', desc = '󰎕 Neovim News' },
      { '<leader>q', desc = '󰁮 Open diagnostic [Q]uickfix list' },
      { '<leader>S', desc = '󰠮 Select Scratch Buffer' },
      { '<leader>z', desc = '󰛑 Toggle Zen Mode' },
      { '<leader>Z', desc = '󰊖 Toggle Zoom' },

      -- Buffer operations
      { '<leader>b', desc = '󰆴 Delete Buffer' },

      -- Code operations
      { '<leader>c', desc = '󰑕 Rename File' },

      -- Search operations
      { '<leader>s.', desc = '󰋚 [S]earch Recent Files ("." for repeat)' },
      { '<leader>s/', desc = '󰍉 [S]earch [/] in Open Files' },
      { '<leader>s"', desc = '󰅽 Registers' },
      { '<leader>sa', desc = '󰀫 Autocmds' },
      { '<leader>sb', desc = '󰓩 Buffer Lines' },
      { '<leader>sB', desc = '󰍉 Grep Open Buffers' },
      { '<leader>sc', desc = '󰏘 [S]earch [C]olorSchemes' },
      { '<leader>sC', desc = '󰘳 Commands' },
      { '<leader>sd', desc = '󰒡 [S]earch [D]iagnostics' },
      { '<leader>sD', desc = '󰒡 Buffer Diagnostics' },
      { '<leader>sf', desc = '󰈞 [S]earch [F]iles' },
      { '<leader>sg', desc = '󰛔 [S]earch by [G]rep' },
      { '<leader>sh', desc = '󰋗 [S]earch [H]elp' },
      { '<leader>sH', desc = '󰸱 Highlights' },
      { '<leader>si', desc = '󰀻 Icons' },
      { '<leader>sj', desc = '󰕌 Jumps' },
      { '<leader>sk', desc = '󰌋 [S]earch [K]eymaps' },
      { '<leader>sl', desc = '󰖷 Location List' },
      { '<leader>sm', desc = '󰃀 Marks' },
      { '<leader>sM', desc = '󰗚 Man Pages' },
      { '<leader>sn', desc = '󰈞 [S]earch [N]eovim files' },
      { '<leader>sp', desc = '󰏖 Search for Plugin Spec' },
      { '<leader>sq', desc = '󰖷 Quickfix List' },
      { '<leader>sr', desc = '󰁯 [S]earch [R]esume' },
      { '<leader>sR', desc = '󰁯 Resume' },
      { '<leader>ss', desc = '󰔎 [S]earch [S]elect Telescope' },
      { '<leader>sS', desc = '󰒕 LSP Workspace Symbols' },
      { '<leader>su', desc = '󰕌 Undo History' },
      { '<leader>sw', desc = '󰓫 [S]earch current [W]ord' },

      -- Git operations
      { '<leader>gb', desc = '󰘬 Git Branches' },
      { '<leader>gB', desc = '󰖟 Git Browse' },
      { '<leader>gd', desc = '󰦓 Git Diff (Hunks)' },
      { '<leader>gf', desc = '󰊢 Git Log File' },
      { '<leader>gg', desc = '󰊢 Lazygit' },
      { '<leader>gl', desc = '󰦓 Git Log' },
      { '<leader>gL', desc = '󰦓 Git Log Line' },
      { '<leader>gs', desc = '󰊢 Git Status' },
      { '<leader>gS', desc = '󰘬 Git Stash' },

      -- File operations
      { '<leader>fb', desc = '󰸩 Buffers' },
      { '<leader>fc', desc = '󰒓 Find Config File' },
      { '<leader>ff', desc = '󰈞 Find Files' },
      { '<leader>fg', desc = '󰊢 Find Git Files' },
      { '<leader>fp', desc = '󰏖 Projects' },
      { '<leader>fr', desc = '󰋚 Recent' },

      -- Util/Toggle operations
      { '<leader>ub', desc = '󰔡 Toggle Dark Background' },
      { '<leader>uc', desc = '󰔡 Toggle conceallevel' },
      { '<leader>uC', desc = '󰏘 Colorschemes' },
      { '<leader>ud', desc = '󰔡 Toggle Diagnostics' },
      { '<leader>uD', desc = '󰔡 Toggle Dimming' },
      { '<leader>ug', desc = '󰔡 Toggle Indent Guides' },
      { '<leader>uh', desc = '󰔡 Toggle Inlay Hints' },
      { '<leader>ul', desc = '󰔡 Toggle Line Numbers' },
      { '<leader>uL', desc = '󰔡 Toggle Relative Number' },
      { '<leader>un', desc = '󰎟 Dismiss All Notifications' },
      { '<leader>us', desc = '󰔡 Toggle Spelling' },
      { '<leader>uT', desc = '󰔡 Toggle Treesitter Highlight' },
      { '<leader>uw', desc = '󰔡 Toggle Wrap' },

      -- Harpoon operations
      { '<leader><leader>a', desc = '󱡀 Add file' },
      { '<leader><leader>e', desc = '󱡀 Toggle quick menu' },
      { '<leader><leader>m', desc = '󱡀 Show marks in Telescope' },
      { '<leader><leader>t', desc = '󰆍 Go to terminal window' },

      -- AI/CodeCompanion operations
      { '<leader>A', desc = '󱙺 CodeCompanion', mode = { 'n', 'v' } },
      { '<leader>Ac', desc = '󱙺 Toggle chat', mode = { 'n', 'v' } },
      { '<leader>Ap', desc = '󱙺 Open action palette', mode = { 'n', 'v' } },
      { '<leader>Aq', desc = '󱙺 Open inline assistant', mode = { 'n', 'v' } },
      { '<leader>Aa', desc = '󱙺 Add selection to chat', mode = 'v' },

      -- ScreenKey
      { '<leader>kt', desc = 'Toggle ScreenKey' },
    },
  },
}
