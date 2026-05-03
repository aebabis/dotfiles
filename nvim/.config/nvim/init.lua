-- lazy.nvim calls vim.loader.enable(); suppress it to avoid ENAMETOOLONG
-- on vim.pack's deep cache paths (site/pack/core/opt/...). Remove once lazy is gone.
vim.loader.enable = function() end
vim.cmd('source ~/.vimrc');

-- vim.pack plugins
require('plugins.autocomplete');
require('plugins.autosave');
require('plugins.colorschemes');
require('plugins.filetree');
require('plugins.git');
require('plugins.git-diff');
require('plugins.git-staging');
require('plugins.journal');
require('plugins.lsp');
require('plugins.notifications');
require('plugins.search');
require('plugins.treesitter');
require('plugins.which-key');

-- Correct priority for dockerfiles that end in an existing extension
-- this allows `dockerfile.<commonExt> to resolve as a dockerfile for syntax highlighting
vim.filetype.add({
  pattern = {
    ['Dockerfile%..*'] = { 'dockerfile', { priority = math.huge } }
  }
})
require('config.autocmd')

vim.cmd.colorscheme('nightfox')
