vim.pack.add({
  'https://github.com/sindrets/diffview.nvim',
});

vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { desc = 'Diff view' });
vim.keymap.set('n', '<leader>gL', '<cmd>DiffviewFileHistory %<cr>', { desc = 'File history' });
vim.keymap.set('n', '<leader>gH', '<cmd>DiffviewFileHistory<cr>', { desc = 'Repo history' });

require('diffview').setup({
  keymaps = {
    view         = { { 'n', '<leader>gx', '<cmd>DiffviewClose<cr>', { desc = 'Close diff view' } } },
    file_panel   = { { 'n', '<leader>gx', '<cmd>DiffviewClose<cr>', { desc = 'Close diff view' } } },
    file_history_panel = { { 'n', '<leader>gx', '<cmd>DiffviewClose<cr>', { desc = 'Close diff view' } } },
  },
});
