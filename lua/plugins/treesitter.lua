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
                disable = function(lang, buf)
                    local max_filesize = 500 * 1024 -- 500 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
        })
    end,
}
