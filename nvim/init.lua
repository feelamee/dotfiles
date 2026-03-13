local modules = {
	'opts',
	'keymap',
	'deps',
	'lsp',
	'autocmd',
}

-- Refresh module cache
for k, v in pairs(modules) do
  package.loaded[v] = nil
  require(v)
end

vim.cmd.source(vim.fn.stdpath("config") .. "/init2.vim")

