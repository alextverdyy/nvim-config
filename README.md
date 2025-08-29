# Neovim Config by tverdyy

A modern, modular, and minimal Neovim setup focused on productivity, clean visuals, and powerful language tooling. Inspired by IDEs, Catppuccin colors, and a love for great keymaps.

---

## ✨ Features
- **Minimal, pastel statusline** (lualine + navic)
- **LSP everywhere** (diagnostics, breadcrumbs, code actions)
- **Fuzzy finding** (fzf-lua, harpoon)
- **Advanced navigation** (nvim-tree, window-picker, smart-splits)
- **Code intelligence** (completion, linting, refactoring, Copilot, CodeCompanion)
- **iOS/Swift development** (Xcodebuild, Overseer, DAP)
- **Task runner, debugging, git integration**
- **Session management, buffer management, surround, folding, macros, snacks, and more!**

---

## 📦 Plugin Highlights

### UI & Navigation
- **lualine.nvim**: Minimal statusline with Catppuccin colors and LSP breadcrumbs
- **nvim-navic**: Breadcrumbs for current code context
- **nvim-navbuddy**: Floating window for code navigation (`<leader>nb`)
- **fzf-lua**: Fuzzy finder for files, buffers, grep, etc
- **nvim-tree**: File explorer
- **harpoon**: Quick file/project navigation
- **window-picker**: Pick and jump to windows
- **smart-splits**: Resize and move splits easily

### Coding & LSP
- **nvim-lspconfig**: LSP setup for all major languages
- **completion.nvim**: Autocompletion
- **conform.nvim**: Formatting
- **lint.nvim**: Linting
- **copilot.nvim**: GitHub Copilot AI
- **codecompanion.nvim**: AI code assistant
- **refactoring.nvim**: Refactoring tools
- **nvim-navbuddy**: Code navigation and context

### Editor Power
- **treesitter**: Syntax highlighting and parsing
- **mini.surround**: Surround text objects
- **comment.nvim**: Easy commenting
- **ufo.nvim**: Folding
- **wildfire.nvim**: Expand selection
- **macros.nvim**: Macro recording
- **inc-rename.nvim**: Incremental rename

### Tools & Misc
- **overseer.nvim**: Task runner
- **toggleterm.nvim**: Terminal management
- **spectre.nvim**: Search/replace across project
- **bqf.nvim**: Quickfix enhancements
- **bufdelete.nvim**: Buffer management
- **auto-session.nvim**: Session management
- **todo-comments.nvim**: Highlight TODOs
- **which-key.nvim**: Keymap hints
- **precognition.nvim**: Predictive navigation
- **nap.nvim**: Next/prev operator motions
- **gitsigns.nvim**: Git integration

### iOS/Swift (macOS only)
- **Xcodebuild, Overseer, DAP, Swift tools**: Full iOS workflow in Neovim

---

## 🎹 Key Mappings (The Cool Stuff)

```text
General
  <Esc>         : Clear search highlight
  <C-s>         : Save file (normal/insert/visual)
  <C-h/j/k/l>   : Move between splits
  ;             : Enter command mode
  <leader>q     : Open diagnostic quickfix list

Navigation & Fuzzy Finding
  <leader><space> : Smart Find Files (fzf-lua)
  <leader>,       : Buffers (fzf-lua)
  <leader>/       : Grep (fzf-lua)
  <leader>fb      : Buffers (fzf-lua)
  <leader>e       : Toggle nvim-tree
  <leader>g       : Toggle Lazygit
  <leader>wp      : Pick a window

LSP & Code
  <leader>nb      : Open Navbuddy (floating code navigation)
  grn             : LSP Rename
  gra             : LSP Code Action
  grd             : Goto Definition (fzf-lua)
  grr             : Goto References (fzf-lua)
  gri             : Goto Implementation (fzf-lua)
  grt             : Goto Type Definition (fzf-lua)
  <leader>ds      : Document Symbols (fzf-lua)
  <leader>ws      : Workspace Symbols (fzf-lua)
  <leader>th      : Toggle Inlay Hints

Folds & Selection
  zR/zM           : Open/close all folds (ufo)
  s/S             : Flash jump/treesitter
  gza/gzd         : Add/Delete surround (mini.surround)

iOS/Swift (macOS)
  <leader>x       : iOS Development menu
  <leader>xp      : Xcodebuild Picker
  <leader>xb      : Build project
  <leader>xr      : Run project
  <leader>xt      : Run tests
  <leader>xc      : Clean build
  <leader>xs      : Select scheme
  <leader>xd      : Select device
  <leader>xq      : Show quickfix
  <leader>fp      : Find projects
  <leader>o       : Tasks menu
  <leader>or      : Run task
  <leader>ot      : Toggle tasks
  <leader>oa      : Task actions
  <leader>oi      : Task info
  <leader>ob      : Build task
  <leader>oq      : Quick action

Debugging (DAP)
  <leader>d       : Debug menu
  <leader>db      : Toggle breakpoint
  <leader>dB      : Conditional breakpoint
  <leader>dc      : Continue
  <leader>dn      : Step over
  <leader>ds      : Step into
  <leader>do      : Step out
  <leader>dr      : Open REPL
  <leader>dl      : Run last
  <leader>du      : Toggle UI
  <leader>dq      : Quit debug session

Git
  <leader>gb      : Git Blame Line

Buffer & Misc
  <leader>bd      : Delete buffer
  <leader>bD      : Wipeout buffer
```

---

## 🛠️ Setup & Usage
- Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.
- All plugins are modularized by category in `lua/plugins/`.
- Keymaps are centralized in `lua/core/keymaps.lua` for easy editing.
- Statusline, colors, and UI are Catppuccin-inspired and minimal.
- LSP, completion, and code intelligence are first-class citizens.
- iOS/Swift workflow is fully supported on macOS.

---

## 🚀 Quickstart
1. Clone this repo into your Neovim config folder (`~/.config/nvim`)
2. Open Neovim and let lazy.nvim sync plugins
3. Enjoy your new IDE-like, minimal, and powerful Neovim!

---

## 🤝 Credits
- All plugin authors and the Neovim community
- Catppuccin theme for color inspiration
- You, for customizing and using this config!
