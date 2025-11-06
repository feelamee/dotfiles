local modules = {
	'opts',
	'keymap',
	'deps',
	'lsp',
}

-- Refresh module cache
for k, v in pairs(modules) do
  package.loaded[v] = nil
  require(v)
end

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})
