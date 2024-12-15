return {
    {
        {
            -- null-ls setup
            "jose-elias-alvarez/null-ls.nvim",
            opts = function(_, opts)
                local null_ls = require("null-ls")

                -- Ensure the sources table exists
                opts.sources = opts.sources or {}

                -- Add Prettier as a formatter
                vim.list_extend(opts.sources, {
                    null_ls.builtins.formatting.prettier.with({
                        extra_args = {
                            "--config-precedence",
                            "prefer-file", -- Prefer project config
                            "--tab-width",
                            "2", -- Use 2 spaces for indentation (common in JavaScript/TypeScript)
                            "--single-quote", -- Use single quotes instead of double quotes for strings
                            "--trailing-comma",
                            "all", -- Add trailing commas where valid in ES5 (objects, arrays)
                            "--semi",
                            "true", -- Use semicolons at the end of statements
                            "--bracket-spacing",
                            "true", -- Add spaces between brackets (e.g., { foo: bar } instead of {foo: bar})
                            "--print-width",
                            "80", -- Set the print width (default: 80 characters per line)
                            "--jsx-single-quote",
                            "true", -- Use single quotes in JSX (for React code)
                            "--quote-props",
                            "as-needed", -- Quote properties only when necessary
                            "--arrow-parens",
                            "always", -- Always include parentheses around arrow function parameters
                        },
                    }),
                })
            end,
        },
    },
    {
        -- Integration between Mason and null-ls
        "jay-babu/mason-null-ls.nvim",
        opts = {
            ensure_installed = { "prettier" }, -- Ensure Prettier is installed
            automatic_installation = true, -- Auto-install missing tools
        },
    },
}
