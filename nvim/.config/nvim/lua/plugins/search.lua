local getConfig = function()
  local actions = require('fzf-lua.actions')
  local config = {
    'fzf-vim',
    grep = {
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
  if vim.fn.executable('fd') ~= 1 then
    config.files = { cmd = 'find -f .' }
  end
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

      vim.keymap.set('n', '<leader>ss', fzf.grep) -- search
      -- Live grep whole project
      vim.keymap.set('n', '<leader>sg', fzf.live_grep)
      vim.keymap.set('n', '<leader>sgr', fzf.live_grep_resume)
      -- filenames
      vim.keymap.set('n', '<leader>sf', fzf.files)
      vim.keymap.set('n', '<leader>sb', fzf.buffers)
      -- lines in buffer(s)
      vim.keymap.set('n', '<leader>sbl', fzf.blines)
      vim.keymap.set('n', '<leader>sl', fzf.lines)
      -- tokens from treesitter
      vim.keymap.set('n', '<leader>st', fzf.treesitter)
      -- documentation
      vim.keymap.set('n', '<leader>sh', fzf.helptags)
      vim.keymap.set('n', '<leader>sm', fzf.manpages)
      -- theme selector
      vim.keymap.set('n', '<leader>st', fzf.colorschemes)
      -- look at keymaps
      vim.keymap.set('n', '<leader>sk', fzf.keymaps)
      -- history of search
      vim.keymap.set('n', '<leader>sh', fzf.search_history)
    end
  }
}
