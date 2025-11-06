-- mini.deps setup

local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		'git', 'clone', '--filter=blob:none',
		'https://github.com/echasnovski/mini.nvim', mini_path
	}
	local r = vim.system(clone_cmd):wait()
	if r.code == 0 then
		vim.cmd('packadd mini.nvim | helptags ALL')
		vim.cmd('echo "Installed `mini.nvim`" | redraw')
	else
		vim.notify(r.stderr, vim.log.levels.ERROR)
		return
	end
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

		-- mappings = {
		-- 	goto_top = '[[',
		-- 	goto_bottom = ']]',
		-- },
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
			-- choose_marked = '<CR>',
			open_selected = {
				char = '<CR>',
				func = function()
					MiniPick.stop()
					local matches = MiniPick.get_picker_matches()
					MiniPick.default_choose(matches.current)
					for _, f in ipairs(matches.marked)
					do
						MiniPick.default_choose(f)
					end
				end
			},

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
		'<leader>;',
		MiniPick.builtin.resume,
		{ desc = 'Open last picker' }
	)

	vim.keymap.set(
		'n',
		'<leader>g',
		MiniPick.builtin.grep_live,
		{ desc = 'Open live grep picker' }
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
			-- set true to make neovim fully transparent
			transparency = false,
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

now(function()
	add({
		source = 'f-person/git-blame.nvim',
		checkout = 'master',
	})

	require('gitblame').setup({
		event = 'VeryLazy',
		enabled = true,
		message_template = " <author> • <date> • <summary>",
		date_format = "%r",
		virtual_text_column = 50, 
		message_when_not_committed = '',
	})
end)
