local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                     ]],
	[[       ████ ██████           █████      ██                     ]],
	[[      ███████████             █████                             ]],
	[[      █████████ ███████████████████ ███   ███████████   ]],
	[[     █████████  ███    █████████████ █████ ██████████████   ]],
	[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
	[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
	[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
}

-- Set menu
dashboard.section.buttons.val = {
	dashboard.button("n", "  > New file", ":ene <BAR> startinsert<CR>"),
	dashboard.button("s", "󰈞  > Find file", ":Telescope find_files<CR>"),
	dashboard.button("t", "  > Find text", ":Telescope live_grep<CR>"),
	dashboard.button("r", "  > Recent files", ":Telescope oldfiles<CR>"),
	dashboard.button("u", " > Update Plugins", ":PackerSync<CR>"),
	dashboard.button("q", " > Quit NVIM", ":qa<CR>"),
}

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Hide cursor
vim.api.nvim_create_autocmd("User", {
	pattern = "AlphaReady",
	desc = "hide cursor for alpha",
	callback = function()
		local hl = vim.api.nvim_get_hl_by_name("Cursor", true)
		hl.blend = 100
		vim.api.nvim_set_hl(0, "Cursor", hl)
		vim.opt.guicursor:append({ "a:Cursor/lCursor" })
	end,
})

-- Show cursor
vim.api.nvim_create_autocmd("BufUnload", {
	buffer = 0,
	desc = "show cursor after alpha",
	callback = function()
		local hl = vim.api.nvim_get_hl_by_name("Cursor", true)
		hl.blend = 0
		vim.api.nvim_set_hl(0, "Cursor", hl)
		vim.opt.guicursor:remove({ "a:Cursor/lCursor" })
	end,
})
