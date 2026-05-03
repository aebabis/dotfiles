vim.cmd('source ~/.vimrc');

-- vim.pack plugins
require('plugin.autocomplete');
require('plugin.autosave');
require('plugin.journal');
require('plugin.treesitter');

require('config.lazy')
-- Correct priority for dockerfiles that end in an existing extension
-- this allows `dockerfile.<commonExt> to resolve as a dockerfile for syntax highlighting
vim.filetype.add({
  pattern = {
    ['Dockerfile%..*'] = { 'dockerfile', { priority = math.huge } }
  }
})
require('config.autocmd')

vim.cmd.colorscheme('nightfox')
