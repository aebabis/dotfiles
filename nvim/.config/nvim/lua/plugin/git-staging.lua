vim.opt.signcolumn = 'yes';

vim.pack.add({
  'https://github.com/lewis6991/gitsigns.nvim',
});

local gs = require('gitsigns');

gs.setup({
  signs = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '' },
    topdelete = { text = '' },
    changedelete = { text = '▎' },
    untracked = { text = '▎' },
  },
  signs_staged = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '' },
    topdelete = { text = '' },
    changedelete = { text = '▎' },
  },
});

local function map(mode, l, r, desc)
  vim.keymap.set(mode, l, r, { desc = desc })
end

-- stylua: ignore start
map('n', ']h', function()
  if vim.wo.diff then
    vim.cmd.normal({ ']c', bang = true })
  else
    gs.nav_hunk('next')
  end
end, 'Next Hunk')
map('n', '[h', function()
  if vim.wo.diff then
    vim.cmd.normal({ '[c', bang = true })
  else
    gs.nav_hunk('prev')
  end
end, 'Prev Hunk')
map('n', ']H', function() gs.nav_hunk('last') end, 'Last Hunk')
map('n', '[H', function() gs.nav_hunk('first') end, 'First Hunk')
map({ 'n', 'v' }, '<leader>ghs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
map({ 'n', 'v' }, '<leader>ghr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
map('n', '<leader>ghS', gs.stage_buffer, 'Stage Buffer')
map('n', '<leader>ghR', gs.reset_buffer, 'Reset Buffer')
map('n', '<leader>ghp', gs.preview_hunk_inline, 'Preview Hunk Inline')
map('n', '<leader>ghb', function() gs.blame_line({ full = true }) end, 'Blame Line')
map('n', '<leader>ghB', function() gs.blame() end, 'Blame Buffer')
map('n', '<leader>ghd', gs.diffthis, 'Diff This')
map('n', '<leader>ghD', function() gs.diffthis('~') end, 'Diff This ~')
map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk')
