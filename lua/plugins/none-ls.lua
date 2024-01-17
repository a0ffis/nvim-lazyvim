return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,

                null_ls.builtins.formatting.prettier.with({
                    filetypes = {
                        "javascript",
                        "javascriptreact",
                        "typescript",
                        "typescriptreact",
                        "vue",
                        "svelte",
                        "css",
                        "scss",
                        "json",
                        "yaml",
                        "html",
                        "markdown",
                        "lua",
                        "python",
                        "rust",
                        "sh",
                        "dockerfile",
                        "go",
                        "graphql",
                        "java",
                        "php",
                        "ruby",
                        "vim",
                        "xml",
                        "yaml",
                    },
                }),
                null_ls.builtins.formatting.stylelint.with({
                    filetypes = {
                        "css",
                        "scss",
                    },
                }),
            },
        })
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format buffer" })
    end,
}
