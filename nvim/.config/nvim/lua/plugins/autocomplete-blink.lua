-- https://gist.github.com/smnatale/2dd6cfb0d96818bbe44c03dc3d92f3d5

vim.pack.add({
	{ src = 'https://github.com/L3MON4D3/LuaSnip' },
	{ src = 'https://github.com/rafamadriz/friendly-snippets' },
	{ src = 'https://github.com/Saghen/blink.cmp', version = 'v1' },
})

require('luasnip.loaders.from_vscode').lazy_load()
require('blink.cmp').setup({
	keymap = {
		preset = 'default',
		['<C-j>'] = { 'select_next', 'fallback' },
		['<C-k>'] = { 'select_prev', 'fallback' },
	},
	signature = { enabled = true },
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			auto_show = true,
			draw = {
				treesitter = { 'lsp' },
				columns = { { 'kind_icon', 'label', 'label_description', gap = 1 }, { 'kind' } },
			},
		},
	},
})
