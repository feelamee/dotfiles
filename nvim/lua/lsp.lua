vim.lsp.config.clangd = {
	cmd = {
		'clangd',
		'--clang-tidy',
		'--background-index',
		'--offset-encoding=utf-8',
	},
	root_markers = { '.clangd', 'compile_commands.json' },
	filetypes = { 'c', 'cpp' },
}

vim.keymap.set(
	{ 'n', 'v' },
	'<leader>d',
	vim.lsp.buf.implementation,
	{ desc = 'show all implementations of symbol' }
)

vim.keymap.set(
	{ 'n', 'v' },
	'<leader>s',
	-- stolen from nvim-lspconfig clangd configuration
	function(bufnr)
		local method_name = 'textDocument/switchSourceHeader'
		local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd' })[1]
		if not client then
			return vim.notify(('method %s is not supported by any servers active on the current buffer'):format(method_name))
		end
		local params = vim.lsp.util.make_text_document_params(bufnr)
		client.request(method_name, params, function(err, result)
			if err then
				error(tostring(err))
			end
			if not result then
				vim.notify('corresponding file cannot be determined')
				return
			end
			vim.cmd.edit(vim.uri_to_fname(result))
		end, bufnr)
	end,
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

vim.keymap.set(
	{ 'n', 'v' },
	'<leader>t',
	function()
		vim.lsp.buf.workspace_symbol({ includeDeclaration = false })
	end,
	{ desc = 'show all workspace symbols' }
)

vim.lsp.enable({ 'clangd' })
