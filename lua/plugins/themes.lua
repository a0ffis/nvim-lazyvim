return {
    -- NOTE: dracula
    {
        "Mofiqul/dracula.nvim",
        config = function()
            local dracula = require("dracula")
            dracula.setup({
                transparent_bg = true,
                colors = {
                    bg = "#282a36",
                },
            })
            vim.cmd.colorscheme("dracula")
        end,
    },
    -- NOTE: catppuccin
    -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
