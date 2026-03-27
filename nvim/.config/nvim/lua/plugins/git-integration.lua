return {
  {
    'tpope/vim-fugitive', -- FUGITIVE
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      { "<leader>gs" }
    },
    config = function()
      -- Git status
      vim.keymap.set('n', '<leader>gs', vim.cmd.Git);

      -- Git blame
      vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>');
    end
  },
  {
    'sindrets/diffview.nvim',
    lazy = true,
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>',            desc = 'Diff view' },
      { '<leader>gL', '<cmd>DiffviewFileHistory %<cr>',   desc = 'File history' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>',     desc = 'Repo history' },
      { '<leader>gx', '<cmd>DiffviewClose<cr>',           desc = 'Close diff view' },
    },
  },
}

