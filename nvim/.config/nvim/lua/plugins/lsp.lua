vim.pack.add({
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
	{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
	{ src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/pmizio/typescript-tools.nvim' },
})

require('mason').setup()
require('mason-lspconfig').setup({
	automatic_enable = {
		exclude = { 'ts_ls' },
	},
})
require('mason-tool-installer').setup({
	ensure_installed = {
		'lua_ls',
		'stylua',
	},
})

require('typescript-tools').setup({})

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = {
					'vim',
					'require',
				},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { remap = false })
vim.keymap.set('n', '<leader>vl', vim.diagnostic.setqflist, { remap = false })
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, { remap = false })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, { remap = false })

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf, remap = false }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>vf',
      function() vim.lsp.buf.format({ filter = function(c) return c.name ~= 'typescript-tools' end }) end, opts)
    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
  end,
})
