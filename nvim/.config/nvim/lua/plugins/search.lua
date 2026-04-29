local getConfig = function()
  local actions = require('fzf-lua.actions')
  local config = {
    'fzf-vim',
    grep = {
      hidden = true,
      actions = {
        -- this action toggles between 'grep' and 'live_grep'
        ["ctrl-g"] = { actions.grep_lgrep },
        -- Toggles use of .gitignore to filter out results
        ["ctrl-r"] = { actions.toggle_ignore },
        -- Toggles visibility of hidden files
        ["ctrl-s"] = { actions.toggle_hidden }
      },
    },
    winopts = {
      on_create = function()
        vim.keymap.set('t', '<C-j>', '<Down>', { silent = true, buffer = true });
        vim.keymap.set('t', '<C-k>', '<Up>',   { silent = true, buffer = true });
      end,
    },
  }
  return config
end

return {
  { 'junegunn/fzf', build = './install --bin' },
  { 'TamaMcGlinn/quickfixdd' },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('fzf-lua').setup(getConfig())
      local fzf = require('fzf-lua')

      vim.keymap.set('n', '<leader>ss',  fzf.grep,              { desc = 'Grep' })
      vim.keymap.set('n', '<leader>sg',  fzf.live_grep,         { desc = 'Live grep' })
      vim.keymap.set('n', '<leader>sgr', fzf.live_grep_resume,  { desc = 'Resume live grep' })
      vim.keymap.set('n', '<leader>sf',  fzf.files,             { desc = 'Files' })
      vim.keymap.set('n', '<leader>sb',  fzf.buffers,           { desc = 'Buffers' })
      vim.keymap.set('n', '<leader>sbl', fzf.blines,            { desc = 'Buffer lines' })
      vim.keymap.set('n', '<leader>sl',  fzf.lines,             { desc = 'Lines' })
      vim.keymap.set('n', '<leader>sc',  fzf.treesitter,        { desc = 'Treesitter tokens' })
      vim.keymap.set('n', '<leader>s?',  fzf.helptags,          { desc = 'Help tags' })
      vim.keymap.set('n', '<leader>sm',  fzf.manpages,          { desc = 'Man pages' })
      vim.keymap.set('n', '<leader>st',  fzf.colorschemes,      { desc = 'Colorschemes' })
      vim.keymap.set('n', '<leader>sk',  fzf.keymaps,           { desc = 'Keymaps' })
      vim.keymap.set('n', '<leader>sh',  fzf.search_history,    { desc = 'Search history' })
    end
  }
}
