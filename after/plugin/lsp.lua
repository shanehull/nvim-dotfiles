local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local cmp = require("cmp")
local cmp_action = lsp_zero.cmp_action()

-- Fix Undefined global 'vim'
lsp_zero.configure("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- Tab through suggestions and Enter to complete
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp_action.tab_complete(),
		["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
})

-- Mason setup - default LSPs
mason.setup({})
mason_lspconfig.setup({
	ensure_installed = {
		"tsserver",
		"eslint",
		"gopls",
		"golangci_lint_ls",
	},
	handlers = {
		lsp_zero.default_setup,
	},
})

-- Config individual LSPs
lspconfig.gopls.setup({
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
})
