vim.pack.add({
  'https://github.com/aebabis/nvim-websocket',
  'https://github.com/aebabis/bitburner.nvim'
})

local bitburner = require('bitburner')
bitburner.setup({
  port                = 12525,
  sync_root           = 'home',
  default_server      = 'home',
  sync_ignore         = { '*.md', '*.json', 'node_modules/**' },
  auto_push           = 'on_save',
  notify_on_push      = false,
  push_all_on_connect = false,
  run_on_push         = false,
  restart_if_running  = false,
  debug               = false,
})
vim.o.statusline = " %f %{%v:lua.require('bitburner').ram_statusline()%} %=%{v:lua.require('bitburner').statusline()} %l:%c "

vim.keymap.set('n', '<leader>bbc', ':BitburnerRun ');
vim.keymap.set('n', '<leader>bbr', function() bitburner.run('["stop.ts", "home", 1, "start.ts"]') end);
