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

vim.cmd.source(vim.fn.stdpath("config") .. "/init2.vim")

-- vim.api.nvim_create_autocmd(
-- 	{'CursorMoved'},
-- 	{
-- 		callback = function(ev)
-- 			local function get_alt_bufnr()
-- 				local alt_bufnr = vim.fn.bufnr('#')
-- 				-- Check if the alternate buffer exists and is loaded
-- 				if alt_bufnr > 0 and vim.api.nvim_buf_is_loaded(alt_bufnr) then
-- 					return alt_bufnr
-- 				end
-- 				return nil
-- 			end

-- 			if vim.fn.win_gettype() == 'quickfix' then
-- 				local qf = vim.fn.getqflist()
-- 				local e = qf[vim.fn.getpos('.')[2]]
-- 				-- print(vim.inspect(e))
-- 				vim.api.nvim_buf_call(
-- 					get_alt_bufnr(),
-- 					function()
-- 						vim.api.nvim_set_current_buf(e.bufnr)
-- 						vim.fn.setpos('.', { e.bufnr, e.lnum, e.col, e.vcol })
-- 					end
-- 				)
-- 			end
-- 		end
-- 	}
-- )
-- -- Minimal version in init.lua
--
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
