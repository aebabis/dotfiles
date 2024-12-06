-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- tabs to spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- make splits appear after focused buffer
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.filetype.add({
  pattern = {
    ['.*.tmux.conf'] = 'tmux'
  },
})
