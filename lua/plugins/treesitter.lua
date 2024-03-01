return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local install = require("nvim-treesitter.install")
        local config = require("nvim-treesitter.configs")

        require("nvim-treesitter.install").compilers = { "zig", "clang" }

        config.setup({
            auto_install = true,
            autotag = {
                enable = true,
            },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
        })
    end,
}
