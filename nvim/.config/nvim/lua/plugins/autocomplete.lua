-- Prevent autoselect
vim.cmd('set completeopt+=noselect');

-- Enable native completion popover
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client ~= nil and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end
  end
});

local function scroll_docs(delta)
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(win).relative ~= '' then
      vim.api.nvim_win_call(win, function()
        vim.fn.winrestview({ topline = math.max(1, vim.fn.winsaveview().topline + delta) })
      end)
      return true
    end
  end
end

vim.keymap.set('i', '<C-f>',     function() return scroll_docs(4)  and '' or '<C-f>' end, { expr = true })
vim.keymap.set('i', '<C-b>',     function() return scroll_docs(-4) and '' or '<C-b>' end, { expr = true })
vim.keymap.set('i', '<C-k>',     function() return vim.fn.pumvisible() == 1 and '<C-p>' or '<C-k>' end, { expr = true })
vim.keymap.set('i', '<C-j>',     function() return vim.fn.pumvisible() == 1 and '<C-n>' or '<C-j>' end, { expr = true })
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>')

vim.keymap.set({ 'i', 's' }, '<Tab>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-n>'
  elseif vim.snippet.active({ direction = 1 }) then
    vim.snippet.jump(1)
    return ''
  else
    return '<Tab>'
  end
end, { expr = true })

vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-p>'
  elseif vim.snippet.active({ direction = -1 }) then
    vim.snippet.jump(-1)
    return ''
  else
    return '<S-Tab>'
  end
end, { expr = true })

