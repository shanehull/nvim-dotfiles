local formatter = require("formatter")
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Exec options
local gofmt = { exe = "gofmt", args = {}, stdin = true }
local prettier = {
	exe = "prettier",
	args = {
		"--stdin-filepath",
		vim.api.nvim_buf_get_name(0),
		"--single-quote",
		"--trailing-comma",
        "all",
	},
	stdin = true,
}
local stylua = { exe = "stylua", args = { "--indent-width", "2", "-" }, stdin = true }
local clang_format = { exe = "clang-format", args = {}, stdin = true }

-- Auto format
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})

-- Setup
formatter.setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		javascript = { prettier },
		typescript = { prettier },
		go = { gofmt },
		c = { clang_format },
		lua = { stylua },
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})
