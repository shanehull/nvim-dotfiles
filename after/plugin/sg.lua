local enable_cody = vim.fn.getenv("ALLOW_AI_ASSIST")

require("sg").setup({
	enable_cody = enable_cody,
})
