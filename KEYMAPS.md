# Neovim Configuration - iOS Development Ready

## Fixed Issues
✅ **Keymap Conflicts Resolved**
- `<C-h/j/k/l>` - Core window navigation preserved
- Smart-splits moved to `<leader>w` prefix
- Terminal toggle moved to `<C-t>` (from `<C-\>`)
- Buffer swapping moved to unique keys

✅ **Completion System**
- Using blink.cmp (single completion engine)
- Removed conflicting nvim-cmp setup
- iOS Swift support included

✅ **Clean iOS Development Environment**
- Removed iOS templates (no auto-generation)
- Focused on development tools only
- Swift syntax highlighting
- Debug support with DAP
- Xcode integration

## Core Navigation
- `<C-h/j/k/l>` - Move between windows
- `<Esc>` - Clear search highlights
- `<Esc><Esc>` - Exit terminal mode

## iOS Development (`<leader>x`)
- `<leader>xp` - Show Xcode picker
- `<leader>xb` - Build project  
- `<leader>xr` - Run project
- `<leader>xt` - Run tests
- `<leader>xc` - Clean build
- `<leader>xs` - Select scheme
- `<leader>xd` - Select device
- `<leader>xq` - Show quickfix

## Debugging (`<leader>d`)
- `<leader>db` - Toggle breakpoint
- `<leader>dc` - Continue
- `<leader>dn` - Step over
- `<leader>ds` - Step into
- `<leader>do` - Step out
- `<leader>du` - Toggle debug UI

## Search & Navigation (`<leader>s`)
- `<leader>sf` - Search files
- `<leader>sg` - Live grep
- `<leader>sw` - Search current word
- `<leader>/` - Search in current buffer

## Window Management
- `<A-h/j/k/l>` - Resize splits
- `<leader>wh/j/k/l` - Move to split
- `<leader>wH/J/K/L` - Swap buffers

## File Management
- `<leader>e` - Toggle NvimTree
- `<leader>fb` - File browser

## Terminal & Tasks
- `<C-t>` - Toggle terminal
- `<leader>or` - Run task
- `<leader>ot` - Toggle tasks

## Other Tools
- `<leader>g` - LazyGit
- `<leader>Ac` - AI Chat
- `<leader>q` - Diagnostics quickfix

## Swift Development Features
- Syntax highlighting with swift.vim
- LSP support via SourceKit-LSP
- DAP debugging configuration
- Xcode project integration
- Build/run/test from Neovim
- Device/simulator selection

## Quality of Life Enhancements
- Auto-session management
- Better quickfix (bqf)
- Smart buffer deletion
- Enhanced folding (ufo)
- Project management
- Window picker
- Visual mode indicators
- Better text objects
