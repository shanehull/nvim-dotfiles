return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = function()
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },

    -- Mason LSP package manager
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },

    -- Auto configure
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-emoji" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

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

            lsp_zero.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "gd", function()
                    vim.lsp.buf.definition()
                end, opts)
                vim.keymap.set("n", "K", function()
                    vim.lsp.buf.hover()
                end, opts)
                vim.keymap.set("n", "<leader>vws", function()
                    vim.lsp.buf.workspace_symbol()
                end, opts)
                vim.keymap.set("n", "<leader>vd", function()
                    vim.diagnostic.open_float()
                end, opts)
                vim.keymap.set("n", "[d", function()
                    vim.diagnostic.goto_next()
                end, opts)
                vim.keymap.set("n", "]d", function()
                    vim.diagnostic.goto_prev()
                end, opts)
                vim.keymap.set("n", "<leader>vca", function()
                    vim.lsp.buf.code_action()
                end, opts)
                vim.keymap.set("n", "<leader>vrr", function()
                    vim.lsp.buf.references()
                end, opts)
                vim.keymap.set("n", "<leader>vrn", function()
                    vim.lsp.buf.rename()
                end, opts)
                vim.keymap.set("i", "<C-h>", function()
                    vim.lsp.buf.signature_help()
                end, opts)
            end)
        end,
    },

    -- Completions
    {
        "hrsh7th/nvim-cmp",
        config = function()
            -- Tab through suggestions and Enter to complete
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
                    ["<Down>"] = cmp.mapping.select_next_item({ behavior = "select" }),
                    --["<Tab>"] = cmp_action.tab_complete(),
                    --["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                }),
                sources = cmp.config.sources({
                    { name = "cody" },
                    { name = "nvim_lsp" },
                }),
            })

            -- Setup cmdline completions
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = "buffer" } },
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = { "Man", "!" },
                        },
                    },
                }),
            })
        end,
    },
}
