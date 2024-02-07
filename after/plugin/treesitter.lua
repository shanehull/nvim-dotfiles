require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"javascript",
		"typescript",
		"c",
		"lua",
		"go",
		"terraform",
	},
	ignore_install = {
		"markdown",
		"markdown_inline",
	},

	sync_install = false,

	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
