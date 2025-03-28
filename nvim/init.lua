-- vim options

vim.g.mapleader = ','

vim.keymap.set(
	'n',
	'<leader>R',
	'<cmd>source $MYVIMRC<cr>',
	{ desc = 'Reload neovim config' }
)

vim.keymap.set(
	'n',
	'<Esc>',
	'<cmd>nohl<cr>',
	{ desc = 'Disable highlight of search matches' }
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
	'"*y',
	{ desc = 'yank to system clipboard' }
)

vim.keymap.set(
	{ 'n', 'v' },
	'<leader>p',
	'"*p',
	{ desc = 'paste from system clipboard' }
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
	{ desc = 'Close all buffers but active' }
)

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.smarttab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.o.scrolloff = 7
vim.o.sidescroll = 1
vim.o.sidescrolloff = 4

vim.o.undofile = true

vim.o.relativenumber = true
vim.o.number = true

vim.o.mouse = ""

-- mini.deps setup

local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require('mini.deps').setup()

-- plugins setup

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
	require('mini.icons').setup()
end)

now(function()
	require('mini.tabline').setup()
end)

now(function()
	require('mini.statusline').setup()
end)

later(function()
	require('mini.bracketed').setup({
		delay = 0,
	})
end)

later(function()
	require('mini.indentscope').setup({
		delay = 0,

		mappings = {
			goto_top = '[[',
			goto_bottom = ']]',
		},
	})
end)

later(function()
	require('mini.cursorword').setup()
end)

later(function()
	require('mini.pairs').setup()
end)

later(function()
	require('mini.splitjoin').setup()
end)

later(function()
	require('mini.files').setup({
		mappings = {
			close = '<Esc>',
		}
	})

	vim.keymap.set(
		'n',
		'<leader>f',
		MiniFiles.open,
		{ desc = 'Open files picker' }
	)
end)

later(function()
	require('mini.comment').setup({
		options = {
			-- Function to compute custom 'commentstring' (optional)
			custom_commentstring = function(arg)
				local ft = vim.bo.filetype
				if ft == 'c' or ft == 'c++' then
					return '// %s'
				end

				return MiniComment.get_commentstring(arg)
			end,

			-- Whether to ignore blank lines in actions and textobject
			ignore_blank_line = true,
		},
	})
end)

later(function()
	require('mini.pick').setup({
		mappings = {
			caret_left  = '<C-b>',
			caret_right = '<C-f>',
		},
	})

	vim.keymap.set(
		'n',
		'<leader>F',
		MiniPick.builtin.files,
		{ desc = 'Open files picker' }
	)
end)

now(function()
	add({
		source = 'rose-pine/neovim',
		checkout = 'master',
	})

	require('rose-pine').setup({
		variant = 'moon', -- auto, main, moon, or dawn
		dark_variant = 'moon', -- main, moon, or dawn

		styles = {
			transparency = true,
		},
	})

	vim.cmd.colorscheme('rose-pine')
end)

later(function()
	add({
		source = 'nvim-treesitter/nvim-treesitter',
		checkout = 'master',
		hooks = { 
			post_checkout = function() vim.cmd('TSUpdate') end
		},
	})

	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"c", "cpp", "lua", "vim", "vimdoc", "query", "markdown",
			"markdown_inline", "kdl", "toml", "json", "yaml", "hyprlang"
		},

		highlight = {
			enable = true,
		},

		indent = {
			enable = true,
		},
	})

	vim.filetype.add({
		pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
	})
end)

