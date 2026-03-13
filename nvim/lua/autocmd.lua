-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})

-- when quickfix cursor line changed - move to appropriate file
-- NOTE! badly work with lsp
if false then
	vim.api.nvim_create_autocmd(
		'CursorMoved',
		{
			pattern = '*',
			callback = function()
				local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
				if buftype ~= 'quickfix' then return end

				local qf_list = vim.fn.getqflist()
				local line = vim.fn.line('.') - 1
				if line < 0 or line >= #qf_list then return end

				local item = qf_list[line + 1]
				if item.bufnr and item.bufnr > 0 then
					-- Find a non-quickfix window
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.api.nvim_buf_get_option(buf, 'buftype') ~= 'quickfix' then
							vim.api.nvim_win_set_buf(win, item.bufnr)
							vim.api.nvim_win_set_cursor(win, {item.lnum or 1, 0})
							break
						end
					end
				end
			end
		}
	)
end
