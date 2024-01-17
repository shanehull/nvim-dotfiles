local should_load_ai_assist = vim.fn.getenv("ALLOW_AI_ASSIST")

if should_load_ai_assist then
	require("sg").setup({})
end
