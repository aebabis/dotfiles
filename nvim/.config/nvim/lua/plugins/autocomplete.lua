return {
  'hrsh7th/nvim-cmp',
  event = {'InsertEnter'},
  dependencies = {
    'hrsh7th/cmp-buffer',
  },
  config = function()
    local cmp = require('cmp')

    cmp.setup({
      sources = {
        {name = 'nvim_lsp'},
      },
      -- TODO: Figure out why none of these do anything
      mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-g>'] = cmp.mapping.complete(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
      }),
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      }, {
        { name = 'buffer' },
      }
    })
  end
}

