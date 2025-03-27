return {
	'ibhagwan/fzf-lua',
	event = 'VeryLazy',
	dependencies = { 'nvim-tree/nvim-web-devicons' },

	config = function(_, opts)
		fzf = require('fzf-lua')

		fzf.setup({
			marks = {
				marks = "%a",
			},

			keymap = {
				builtin = {
					['<C-t>'] = 'toggle-preview',
					['<C-d>'] = 'preview-down',
					['<C-u>'] = 'preview-up',
					['<C-S-d>'] = 'preview-page-down',
					['<C-S-u>'] = 'preview-page-up',
				}
			},

			actions = {
				files = {
					['enter'] = fzf.actions.file_tabedit,
				},
			},
		})

		keys = {
			{ '<leader>m',  fzf.marks,           'search marks' },
			{ '<leader>?',  fzf.keymaps,         'search keymaps' },
			{ '<leader>/',  fzf.live_grep,       'live grep' },
			{ '<leader>f',  fzf.git_files,       'search git file names' },
			{ '<leader>c',  fzf.git_bcommits,    'search git buffer commits' },
			{ '<leader>r',  fzf.resume,          'resume fzf' },
			{ '<leader>b',  fzf.buffers,         'search opened buffers' },
		}

		for _, it in pairs(keys) do
			vim.keymap.set('n', it[1], it[2], { desc = it[3] })
		end
	end,
}
