vim.pack.add({
  { src = 'http://github.com/nvim-treesitter/nvim-treesitter',
  branch = 'main'},
});

require('nvim-treesitter').install({
  'c', 'lua', 'vim', 'vimdoc', 'query', 'elixir', 'heex', 'javascript', 'typescript', 'tsx', 'html'
})
