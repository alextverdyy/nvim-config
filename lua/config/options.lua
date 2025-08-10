local opt = vim.opt
local g = vim.g

-- Leader keys
g.mapleader = " "
g.maplocalleader = "\\"

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.termguicolors = true
opt.cursorline = true
opt.showmode = false

-- Editing
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Files
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.timeoutlen = 300

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Performance
opt.ttyfast = true

-- Other
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.conceallevel = 2
opt.confirm = true
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.inccommand = "nosplit"
opt.pumblend = 10
opt.pumheight = 10
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.smoothscroll = true
opt.spelllang = { "en" }
opt.spelloptions:append("noplainbuffer")
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Color scheme
colorscheme = tokyonight
