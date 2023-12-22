vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		vim.cmd("NERDTree")
		vim.cmd("wincmd p")
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		if
			vim.fn.tabpagenr("$") == 1
			and vim.fn.winnr("$") == 1
			and vim.fn.exists("b:NERDTree") == 1
			and vim.b.NERDTree.isTabTree
		then
			vim.cmd("q")
		end
	end,
})
