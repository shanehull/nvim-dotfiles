return {
	{
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",
		config = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.gofmt,
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.golines,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.alejandra,
					null_ls.builtins.formatting.terraform_fmt,
					null_ls.builtins.formatting.prettierd.with({
						filetypes = {
							"javascript",
							"typescript",
							"css",
							"scss",
							"html",
							"json",
							"yaml",
							"graphql",
							"pandoc",
						},
					}),
					null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.diagnostics.golangci_lint,
					null_ls.builtins.diagnostics.statix,
					null_ls.builtins.completion.spell,
					null_ls.builtins.code_actions.eslint_d,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({
							group = augroup,
							buffer = bufnr,
						})
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
			})
		end,
	},
}
