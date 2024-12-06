local theme = function(path, opts)
  return { path, lazy = true, priority = 1000, opts = opts or {}}
end

return {
  theme('edeneast/nightfox.nvim'),
  theme('folke/tokyonight.nvim', { style = "moon" }),
  theme('miikanissi/modus-themes.nvim'),
  theme('0xstepit/flow.nvim'),
  theme('oxfist/night-owl.nvim'),
  theme('vague2k/vague.nvim'),
}
