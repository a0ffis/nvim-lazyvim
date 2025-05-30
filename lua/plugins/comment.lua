return {
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
    },
    {
        "numToStr/Comment.nvim",
        lazy = false,
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        opts = {
            pre_hook = function(...)
                return require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()(...)
            end,
        },
    },
}
