-- vim options

-- vim.o.exrc = true

vim.g.mapleader = ' '

vim.o.winborder = 'rounded'

vim.o.signcolumn = 'yes'

-- local function get_buffers(options)
--     local buffers = {}

--     for buffer = 1, vim.fn.bufnr('$') do
--         local is_listed = vim.fn.buflisted(buffer) == 1
--         if options.listed and is_listed then
--             table.insert(buffers, buffer)
--         else
--             table.insert(buffers, buffer)
--         end
--     end

--     return buffers
-- end

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

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.smarttab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.o.scrolloff = 7
vim.o.sidescroll = 1
vim.o.sidescrolloff = 4

vim.o.undofile = true

vim.o.relativenumber = false
vim.o.number = true

vim.o.mouse = ""

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})

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

-- :W doas saves the file
-- (useful for handling the permission-denied error)
-- command! W execute 'w !doas tee % > /dev/null' <bar> edit!
-- vim.api.nvim_create_user_command('W', "execute 'w !doas tee % > /dev/null' <bar> edit!", {})

-- plugins setup

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later


later(function()
	add({
		source = 'neovim/nvim-lspconfig',
		depends = { 'williamboman/mason.nvim' },
	})

	require('mason').setup({})

	-- vim.opt.completeopt = { "menuone", "noselect", "popup" }
	require('lspconfig').clangd.setup({
		filetypes = { 'c', 'cpp' },

		-- on_attach = function(client, bufnr)
		-- 	vim.lsp.completion.enable(true, client.id, bufnr, {
		-- 		autotrigger = true,
		-- 		convert = function(item)
		-- 			return { abbr = item.label:gsub("%b()", "") }
		-- 		end,
		-- 	})
		-- 	vim.keymap.set("i", "<C-n>", vim.lsp.completion.get, { desc = "trigger autocompletion" })
		-- end
	})


	require('lspconfig').cmake.setup({})
end)

vim.keymap.set(
	{ 'n', 'v' },
	'<leader>d',
	vim.lsp.buf.implementation,
	{ desc = 'show all implementations of symbol' }
)

vim.keymap.set(
	{ 'n', 'v' },
	'<leader>s',
	'<cmd>ClangdSwitchSourceHeader<cr>',
	{ desc = 'switch source/header' }
)

vim.keymap.set(
	{ 'n', 'v' },
	'gd',
	vim.lsp.buf.definition,
	{ desc = 'switch source/header' }
)

vim.keymap.set(
	{ 'n', 'v' },
	'<leader>r',
	vim.lsp.buf.references,
	{ desc = 'show all references of symbol' }
)

vim.keymap.set(
	{ 'n', 'v' },
	'<leader>R',
	vim.lsp.buf.rename,
	{ desc = 'rename symbol' }
)

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

now(function()
	require('mini.move').setup({
		mappings = {
			left = '<C-h>',
			right = '<C-l>',
			down = '<C-j>',
			up = '<C-k>',

			line_left = '<C-h>',
			line_right = '<C-l>',
			line_down = '<C-j>',
			line_up = '<C-k>',
		},
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
	require('mini.files').setup({
		mappings = {
			close = '<Esc>',
		}
	})

	vim.keymap.set(
		'n',
		'<leader>o',
		MiniFiles.open,
		{ desc = 'Open mini.files' }
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

	local input_actions = function(actions)
	  return function()
		local mappings = MiniPick.get_picker_opts().mappings
		local keys = vim.tbl_map(function(a) return mappings[a] end, actions)
		vim.api.nvim_input(vim.keycode(table.concat(keys)))
	  end
	end

	require('mini.pick').setup({
		mappings = {
			caret_left  = '<C-b>',
			caret_right = '<C-f>',

			choose_in_tabpage = '',

			mark_and_down = {
				char = '<Tab>',
				func = input_actions({ 'mark', 'move_down' })
			},
			mark_and_up = {
				char = '<S-Tab>',
				func = input_actions({ 'mark', 'move_up' })
			},

			delete_left = '',

			scroll_down = '<C-d>',
			scroll_up = '<C-u>',

			toggle_preview = '<C-t>',
			toggle_info    = '<C-/>',
		},
	})

	vim.keymap.set(
		'n',
		'<leader>f',
		function()
			local git_dir = vim.fn.finddir('.git', vim.fn.getcwd() .. ";")
			if git_dir ~= "" then
				MiniPick.builtin.files({ tool = "git" })
			else
				MiniPick.builtin.files()
			end
		end,
		{ desc = 'Open files picker' }
	)

	vim.keymap.set(
		'n',
		'<leader>F',
		MiniPick.builtin.resume,
		{ desc = 'Open last picker' }
	)
end)

now(function()
	add({
		source = 'rose-pine/neovim',
		checkout = 'main',
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
			"markdown_inline", "kdl", "toml", "json", "yaml", "hyprlang",
			"css", "jsonc", "kotlin", "groovy", "hlsl"
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

