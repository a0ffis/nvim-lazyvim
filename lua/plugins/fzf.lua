return {
    "junegunn/fzf.vim",
    run = function()
        vim.cmd("PlugInstall")
        vim.cmd("PlugClean")
    end,

    -- {
    --     "ibhagwan/fzf-lua",
    --     requires = { "nvim-tree/nvim-web-devicons" }, -- optional for icons
    -- },
}
