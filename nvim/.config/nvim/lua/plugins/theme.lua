return {
  'f-person/auto-dark-mode.nvim',
  opts = {
    set_dark_mode = function()
      vim.api.nvim_set_option_value('background', 'dark', {})
      vim.cmd.colorscheme('nightfox')
    end,
    set_light_mode = function()
      vim.api.nvim_set_option_value('background', 'light', {})
      vim.cmd.colorscheme('dayfox')
    end,
    update_interval = 3000,
    fallback = "dark"
  },
  config = function(_, opts)
    local adm = require('auto-dark-mode')
    adm.setup(opts)
    -- Cinnamon doesn't implement org.freedesktop.appearance color-scheme, so the
    -- default dbus query always returns uint32 0 (no preference) → light mode.
    -- Instead, detect dark mode from the GTK theme name.
    if vim.uv.os_uname().sysname == "Linux" then
      adm.state.query_command = {
        'bash', '-c',
        'theme=$(gsettings get org.cinnamon.desktop.interface gtk-theme 2>/dev/null | tr -d "\'");'
          .. '[[ "$theme" == *Dark* ]] && echo "uint32 1" || echo "uint32 0"',
      }
    end
  end,
}
