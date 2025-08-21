return {
    "LunarVim/bigfile.nvim",
    event = "BufReadPre",
    config = function()
        require("bigfile").setup({
            filesize = 1, -- size of the file in MiB, the plugin round file sizes to the closest MiB
            pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
            features = { -- features to disable
                "indent_blankline",
                "illuminate",
                -- "lsp",
                "treesitter",
                "syntax",
                "matchparen",
                -- "vimopts",
                -- "filetype",
            },
            autocmds = {
                function()
                    vim.schedule(function()
                        vim.notify("Bigfile mode: disabled heavy features for performance", vim.log.levels.WARN)
                    end)
                end,
            },
        })
    end,
}
