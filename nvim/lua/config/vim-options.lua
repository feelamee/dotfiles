vim.g.mapleader = ','

vim.keymap.set(
	'n',
	'<leader>R',
	'<cmd>source $MYVIMRC<cr>',
	{ desc = 'Reload neovim config' }
)

vim.keymap.set(
	'n',
	'<Esc><Esc>',
	'<cmd>nohl<cr>',
	{ desc = 'Disable highlight of search matches' }
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
