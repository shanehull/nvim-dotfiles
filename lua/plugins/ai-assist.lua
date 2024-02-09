return {
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
}
