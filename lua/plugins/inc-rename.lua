return {
    "smjonas/inc-rename.nvim",
    -- cmd = "IncRename",
    -- config = true,
    config = function()
        require("inc_rename").setup({
            cmd_name = "IncRename",

            vim.keymap.set("n", "<leader>rn", ":IncRename "),
        })
        -- vim.keymap.set("n", "<leader>rn", function()
        --     return ":IncRename " .. vim.fn.expand("<cword>")
        -- end, { expr = true }),
        -- }
    end,
}
