vim.cmd('source ~/.vimrc');

-- vim.pack plugins
require('plugin.autocomplete');
require('plugin.autosave');
require('plugin.journal');
require('plugin.treesitter');

require('config.lazy')
require('config.mappings')
require('config.autocmd')

vim.cmd.colorscheme('nightfox')
