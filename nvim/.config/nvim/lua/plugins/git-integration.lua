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
}

