return {
  'jakobkhansen/journal.nvim',
  config = function()
    local weeklyTemplate = function(date)
      local t = '%A, %m/%d'
      local template =  '# Week of %Y-%m-%d\n\z
        ## '..os.date(t, os.time(date.date))..'\n\n\z
        ## '..os.date(t, os.time(date:relative({ day = 1 }).date))..'\n\n\z
        ## '..os.date(t, os.time(date:relative({ day = 2 }).date))..'\n\n\z
        ## '..os.date(t, os.time(date:relative({ day = 3 }).date))..'\n\n\z
        ## '..os.date(t, os.time(date:relative({ day = 4 }).date))..'\n\n\z
        ## '..os.date(t, os.time(date:relative({ day = 5 }).date))..'\n\n\z
        ## '..os.date(t, os.time(date:relative({ day = 6 }).date))..'\n'
      template = template:gsub(' 0', ' '):gsub('/0', '/')
      return template
    end
    vim.keymap.set('n', '<leader>jw', function() vim.cmd(':Journal week') end, {desc='Open weekly journal'})
    vim.keymap.set('n', '<leader>jd', function() vim.cmd(':Journal week') end, {desc='Open daily journal'})
    vim.keymap.set('n', '<leader>j1', function() vim.cmd(':Journal week -1') end, {desc='Journal 1 week ago'})
    vim.keymap.set('n', '<leader>j2', function() vim.cmd(':Journal week -2') end, {desc='Journal 2 week ago'})
    vim.keymap.set('n', '<leader>j3', function() vim.cmd(':Journal week -3') end, {desc='Journal 3 week ago'})
    vim.keymap.set('n', '<leader>j4', function() vim.cmd(':Journal week -4') end, {desc='Journal 4 week ago'})
    vim.keymap.set('n', '<leader>j5', function() vim.cmd(':Journal week -5') end, {desc='Journal 5 week ago'})
    vim.keymap.set('n', '<leader>j6', function() vim.cmd(':Journal week -6') end, {desc='Journal 6 week ago'})
    vim.keymap.set('n', '<leader>j7', function() vim.cmd(':Journal week -7') end, {desc='Journal 7 week ago'})
    vim.keymap.set('n', '<leader>j8', function() vim.cmd(':Journal week -8') end, {desc='Journal 8 week ago'})
    vim.keymap.set('n', '<leader>j9', function() vim.cmd(':Journal week -9') end, {desc='Journal 9 week ago'})
    require('journal').setup({
      filetype = 'md',                    -- Filetype to use for new journal entries
      root = '~/Journal',                 -- Root directory for journal entries
      date_format = '%Y-%m-%d',           -- Date format for `:Journal <date-modifier>`
      autocomplete_date_modifier = 'end', -- 'always'|'never'|'end'. Enable date modifier autocompletion
      journal = {
        format = '%Y/%m/weekly/%Y-%m-%d',
        template = weeklyTemplate,
        frequency = { day = 7 },
        date_modifier = 'monday',

        -- Nested configurations for `:Journal <type> <type> ... <date-modifier>`
        entries = {
          day = {
            format = '%Y/%m/daily/%d-%A',
            template = '# %A %B %d %Y\n',
            frequency = { day = 1 },
          },
          week = {
            format = '%Y/%m/weekly/%Y-%m-%d',
            template = weeklyTemplate,
            frequency = { day = 7 },
            date_modifier = 'monday',
          },
          month = {
            format = '%Y/%m/%B',
            template = '# %B %Y\n',
            frequency = { month = 1 }
          },
          year = {
            format = '%Y/%Y',
            template = '# %Y\n',
            frequency = { year = 1 }
          },
        },
      }
    })
  end,
}
