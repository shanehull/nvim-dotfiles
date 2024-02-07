vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.x",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				icons = false,
			})
		end,
	})

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	use("mbbill/undotree")

	use("tpope/vim-fugitive")

	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	-- Markdown syntax highlighting / preview
	use({
		"vim-pandoc/vim-pandoc",
		requires = { "vim-pandoc/vim-pandoc-syntax" },
	})
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown" },
	})

	-- Sourcegraph / Cody
	use({ "sourcegraph/sg.nvim", run = "nvim -l build/init.lua" })

	-- Filetree
	use("nvim-tree/nvim-tree.lua")
	use("nvim-tree/nvim-web-devicons")

	-- PrimeTime lethal weapon
	use("ThePrimeagen/harpoon")

	-- Hide secrets in env files
	use("laytan/cloak.nvim")

	-- Status tab
	use("vim-airline/vim-airline")
	use("vim-airline/vim-airline-themes")

	-- Startup dashboard
	use("goolord/alpha-nvim")

	-- Auto formatting and typing helpers
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use("nvimtools/none-ls.nvim")
	use("preservim/nerdcommenter")

	-- Theme
	use("morhetz/gruvbox")
end)
