-- Set leader keys first (before loading plugins)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load core configuration
require('core')

-- Load plugins
require('plugins')
