return {
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
}

