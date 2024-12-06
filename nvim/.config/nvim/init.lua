-- Load settings first so LazyVim has
-- correct `mapleader` and `maplocalleader`
require('config.settings')
require('config.lazy')
require('config.mappings')

-- User preferences
vim.cmd.colorscheme('nightfox')
vim.cmd('set number')
