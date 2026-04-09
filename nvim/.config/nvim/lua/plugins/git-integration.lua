return {
  {
    'tpope/vim-fugitive', -- FUGITIVE
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      { "<leader>gs", desc = "Git status" }
    },
    config = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.Git,             { desc = 'Git status' });
      vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>',    { desc = 'Git blame' });
    end
  },
  {
    'sindrets/diffview.nvim',
    lazy = true,
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>',            desc = 'Diff view' },
      { '<leader>gL', '<cmd>DiffviewFileHistory %<cr>',   desc = 'File history' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>',     desc = 'Repo history' },
    },
    opts = {
      keymaps = {
        view         = { { 'n', '<leader>gx', '<cmd>DiffviewClose<cr>', { desc = 'Close diff view' } } },
        file_panel   = { { 'n', '<leader>gx', '<cmd>DiffviewClose<cr>', { desc = 'Close diff view' } } },
        file_history_panel = { { 'n', '<leader>gx', '<cmd>DiffviewClose<cr>', { desc = 'Close diff view' } } },
      },
    },
  },
}

