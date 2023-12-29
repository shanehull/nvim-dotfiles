local cmp = require("cmp")

cmp.setup({
	sources = cmp.config.sources({
		{ name = "cody" },
		{ name = "nvim_lsp" },
	}),
})
