vim.cmd('source ~/.vimrc');

-- vim.pack plugins
require('plugin.autosave');

require('config.lazy')
require('config.mappings')
require('config.autocmd')

vim.cmd.colorscheme('nightfox')
