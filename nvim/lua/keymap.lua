-- general keymap settings
-- specific to plugin keymaps are in lua/deps.lua

vim.keymap.set(
	'n',
	'<leader><leader>r',
	function()
		vim.cmd('mapclear')
		vim.cmd('source $MYVIMRC')
	end,
	{ desc = 'Reload neovim config' }
)

vim.keymap.set(
	'n',
	'<leader><leader>c',
	'<cmd>edit $MYVIMRC<cr>',
	{ desc = 'Edit neovim config' }
)

vim.keymap.set(
	'n',
	'<leader>D',
	'<cmd>e!<cr>',
	{ desc = 'Discard unsaved changes' }
)

vim.keymap.set(
	{ 'n', 'v' },
	'<leader>y',
	'"+y',
	{ desc = 'Yank to system clipboard' }
)

vim.keymap.set(
	{ 'n', 'v' },
	'<leader>p',
	'"+p',
	{ desc = 'Paste from system clipboard' }
)

vim.keymap.set(
	{ 'n', 'v' },
	'<leader>P',
	'"+P',
	{ desc = 'Paste from system clipboard' }
)

vim.keymap.set(
	{ 'n', 'v' },
	'<leader>co',
	'<cmd>%bdelete|edit#|bdelete#<cr>',
	{ desc = 'Close all buffers but active' }
)

vim.keymap.set(
	{ 'n', 'v' },
	'<leader>q',
	'<cmd>bd<cr>',
	{ desc = 'Close buffer' }
)

vim.keymap.set(
	{ 'n', 'v' },
	'<leader>Q',
	'<cmd>bd!<cr>',
	{ desc = 'Force close buffer (even if there are unsaved changes)' }
)

vim.keymap.set(
	{ 'n', 'v' },
	'<leader>b',
	'<cmd>:make<cr>',
	{ desc = 'run build' }
)

vim.keymap.set(
	{ 'n', 'v' },
	'<C-y>',
	'<C-y>k',
	{ desc = 'scroll up' }
)

vim.keymap.set(
	{ 'n', 'v' },
	'<C-e>',
	'<C-e>j',
	{ desc = 'scroll down' }
)

vim.keymap.set(
	{ 'n' },
	'<Esc>',
	function()
		vim.cmd(':nohl')

		-- assume that popup or quickfix is always last window
		if vim.fn.win_gettype(vim.fn.winnr('$')) == "popup"
		then
			vim.cmd(':fclose')
		else
			vim.cmd(':cclose')
		end
	end,
	{ desc = 'close quickfix and floating window, disable last search highlight' }
)

