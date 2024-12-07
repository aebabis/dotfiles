local make_window = function(options)
  local handle = vim.api.nvim_open_win(0, false, options)
  vim.api.nvim_set_current_win(handle)
  return handle
end

local get_new_win_height = function()
	local session_height = vim.api.nvim_win_get_height(0)
	local preferred_height = math.floor(session_height / 4)
	if (session_height < 4) then
		return 2
	elseif (session_height < 16) then
		return math.floor(session_height / 2)
	else
		return math.max(8, math.min(preferred_height, 24))
	end
end

local open_split_terminal = function()
  make_window({ split = 'below', win = -1, height = get_new_win_height() })
  vim.cmd(':terminal')
end

-- Quick terminal
vim.keymap.set('n', '<leader>T', open_split_terminal, {desc='Open terminal'})
vim.api.nvim_create_autocmd({ 'TermOpen', 'WinEnter' }, { pattern = 'term://*', command = 'startinsert' })
