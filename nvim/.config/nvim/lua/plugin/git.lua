vim.pack.add({
  'https://github.com/tpope/vim-fugitive',
});
vim.keymap.set('n', '<leader>gs', vim.cmd.Git,             { desc = 'Git status' });
vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>',    { desc = 'Git blame' });
