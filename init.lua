vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load configuration files
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

-- Load plugins
require 'kickstart.plugins'
require 'kickstart.plugins.gitsigns'
require 'kickstart.plugins.lint'
require 'kickstart.plugins.indent_line'
