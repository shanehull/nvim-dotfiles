return {
    {
        "morhetz/gruvbox",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme gruvbox")
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { { "nvim-lua/plenary.nvim" } },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        end,
    },

    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                icons = false,
            })

            vim.keymap.set("n", "<leader>xx", function()
                require("trouble").toggle()
            end)
            vim.keymap.set("n", "<leader>xw", function()
                require("trouble").toggle("workspace_diagnostics")
            end)
            vim.keymap.set("n", "<leader>xd", function()
                require("trouble").toggle("document_diagnostics")
            end)
            vim.keymap.set("n", "<leader>xq", function()
                require("trouble").toggle("quickfix")
            end)
            vim.keymap.set("n", "<leader>xl", function()
                require("trouble").toggle("loclist")
            end)
            vim.keymap.set("n", "gR", function()
                require("trouble").toggle("lsp_references")
            end)
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
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
        end,
    },

    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },

    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

            local TheShed_Fugitive = vim.api.nvim_create_augroup("TheShed_Fugitive", {})

            local autocmd = vim.api.nvim_create_autocmd
            autocmd("BufWinEnter", {
                group = TheShed_Fugitive,
                pattern = "*",
                callback = function()
                    if vim.bo.ft ~= "fugitive" then
                        return
                    end

                    local bufnr = vim.api.nvim_get_current_buf()

                    local opts = { buffer = bufnr, remap = false }

                    vim.keymap.set("n", "<leader>p", function()
                        vim.cmd.Git("push")
                    end, opts)

                    vim.keymap.set("n", "<leader>P", function()
                        vim.cmd.Git({ "pull", "--rebase" })
                    end, opts)
                end,
            })
        end,
    },

    -- Markdown syntax highlighting / preview
    {
        "vim-pandoc/vim-pandoc",
        dependencies = { "vim-pandoc/vim-pandoc-syntax" },
    },
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = { "markdown" },
    },

    -- Sourcegraph / Cody
    {
        "sourcegraph/sg.nvim",
        build = "nvim -l build/init.lua",
        config = function()
            -- Only install if this is set
            -- TODO: better way of doing this env var?
            if vim.fn.filereadable(vim.fn.expand("~/.config/nvim/env.lua")) == 1 then
                vim.cmd("source ~/.config/nvim/env.lua")
            end

            local enable_cody = vim.env.ALLOW_AI_ASSIST == "v:true"

            -- TODO: Revisit this 'enable_cody = false' breaks everything with:
            --       Invalid command (not found): CodyTaskView
            if enable_cody then
                require("sg").setup({
                    enable_cody = enable_cody,
                })
            end
        end,
    },

    -- Filetree
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup({
                sort = {
                    sorter = "case_sensitive",
                },
                view = {
                    width = 30,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
            })

            -- Auto close if last tab
            vim.api.nvim_create_autocmd("BufEnter", {
                nested = true,
                callback = function()
                    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
                        vim.cmd("quit")
                    end
                end,
            })

            vim.keymap.set({ "n", "v" }, "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
        end,
    },
    { "nvim-tree/nvim-web-devicons" },

    -- PrimeTime lethal weapon
    {
        "ThePrimeagen/harpoon",
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
        end,
    },

    -- Hide secrets in env files
    {
        "laytan/cloak.nvim",
        config = function()
            require("cloak").setup({
                enabled = true,
                cloak_character = "*",
                -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
                highlight_group = "Comment",
                -- Applies the length of the replacement characters for all matched
                -- patterns, defaults to the length of the matched pattern.
                cloak_length = nil, -- Provide a number if you want to hide the true length of the value.
                -- Weather it should try every pattern to find the best fit or stop after the first.
                try_all_patterns = true,
                patterns = {
                    {
                        -- Match any file starting with '.env'.
                        -- This can be a table to match multiple file patterns.
                        file_pattern = ".env*",
                        -- Match an equals sign and any character after it.
                        -- This can also be a table of patterns to cloak,
                        -- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
                        cloak_pattern = "=.+",
                        -- A function, table or string to generate the replacement.
                        -- The actual replacement will contain the 'cloak_character'
                        -- where it doesn't cover the original text.
                        -- If left empty the legacy behavior of keeping the first character is retained.
                        replace = nil,
                    },
                },
            })
        end,
    },

    -- Status tab
    { "vim-airline/vim-airline" },
    { "vim-airline/vim-airline-themes" },

    -- Pretty cmdline
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
            })
        end,
    },

    -- Auto formatting and typing helpers
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    {
        "nvimtools/none-ls.nvim",
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
    { "preservim/nerdcommenter" },
}
