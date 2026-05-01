return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {}
  },
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      -- Global capabilities for all LSP servers
      vim.lsp.config('*', {
        capabilities = vim.tbl_deep_extend(
          'force',
          vim.lsp.protocol.make_client_capabilities(),
          require('cmp_nvim_lsp').default_capabilities()
        )
      })

      vim.lsp.config('jsonls', {
        filetypes = { 'json', 'jsonc' },
        settings = {
          json = {
            schemas = {
              { fileMatch = { 'package.json' },                                              url = 'https://json.schemastore.org/package.json' },
              { fileMatch = { 'tsconfig*.json' },                                            url = 'https://json.schemastore.org/tsconfig.json' },
              { fileMatch = { '.prettierrc', '.prettierrc.json', 'prettier.config.json' },   url = 'https://json.schemastore.org/prettierrc.json' },
              { fileMatch = { '.eslintrc', '.eslintrc.json' },                               url = 'https://json.schemastore.org/eslintrc.json' },
              { fileMatch = { '.babelrc', '.babelrc.json', 'babel.config.json' },            url = 'https://json.schemastore.org/babelrc.json' },
              { fileMatch = { 'lerna.json' },                                                url = 'https://json.schemastore.org/lerna.json' },
              { fileMatch = { 'now.json', 'vercel.json' },                                   url = 'https://json.schemastore.org/now.json' },
              { fileMatch = { '.stylelintrc', '.stylelintrc.json', 'stylelint.config.json' }, url = 'http://json.schemastore.org/stylelintrc.json' },
            }
          }
        }
      })

      -- Recognize vim globals for Neovim config editing
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME, '~/.local/share/nvim/lazy' },
            },
          }
        }
      })

      -- Prettier formatting for JS/TS via efm
      local prettier = {
        formatCommand = [[$([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "prettier") --stdin-filepath ${INPUT} ]],
        formatStdin = true,
      }
      local efm_languages = { typescript = { prettier }, typescriptreact = { prettier }, javascript = { prettier } }
      vim.lsp.config('efm', {
        filetypes = vim.tbl_keys(efm_languages),
        settings = { rootMarkers = { '.git/' }, languages = efm_languages },
        init_options = { documentFormatting = true },
      })

      -- nvim 0.11+ sets K (hover), grn (rename), gra (code_action), grr (references), <C-s> (signature_help) by default
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf, remap = false }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
          vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '<leader>vl', vim.diagnostic.setqflist, opts)
          vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, opts)
          vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, opts)
          vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>vf',
            function() vim.lsp.buf.format({ filter = function(c) return c.name ~= 'ts_ls' end }) end, opts)
          vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
        end,
      })
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      ensure_installed = { 'ts_ls', 'eslint', 'lua_ls', 'yamlls', 'jsonls' },
      automatic_enable = {
        exclude = { 'ts_ls', 'eslint' },
      },
    },
  }
}
