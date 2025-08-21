return {
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            -- ensure_installed = { "vtsls", "eslint" },
            ensure_installed = { "eslint" },
            automatic_installation = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        opts = {
            setup = {
                -- vtsls = function()
                --     local lspconfig = require("lspconfig")
                --     local capabilities = require("cmp_nvim_lsp").default_capabilities()
                --     local util = require("lspconfig.util")
                --     lspconfig.vtsls.setup({
                --         capabilities = capabilities,
                --         flags = { debounce_text_changes = 200 },
                --         root_dir = util.root_pattern("tsconfig.json", "package.json", ".git"),
                --         settings = {
                --             complete_function_calls = false,
                --             javascript = {
                --                 suggest = { completeFunctionCalls = false },
                --                 inlayHints = {
                --                     enumMemberValues = { enabled = false },
                --                     functionLikeReturnTypes = { enabled = false },
                --                     parameterNames = { enabled = "none" },
                --                     parameterTypes = { enabled = false },
                --                     propertyDeclarationTypes = { enabled = false },
                --                     variableTypes = { enabled = false },
                --                 },
                --                 updateImportsOnFileMove = { enabled = "always" },
                --             },
                --             typescript = {
                --                 suggest = { completeFunctionCalls = false },
                --                 inlayHints = {
                --                     enumMemberValues = { enabled = false },
                --                     functionLikeReturnTypes = { enabled = false },
                --                     parameterNames = { enabled = "none" },
                --                     parameterTypes = { enabled = false },
                --                     propertyDeclarationTypes = { enabled = false },
                --                     variableTypes = { enabled = false },
                --                 },
                --                 updateImportsOnFileMove = { enabled = "always" },
                --             },
                --             vtsls = {
                --                 autoUseWorkspaceTsdk = true,
                --                 enableMoveToFileCodeAction = true,
                --                 experimental = {
                --                     completion = { enableServerSideFuzzyMatch = false },
                --                     maxInlayHintLength = 30,
                --                 },
                --                 tsserver = { maxTsServerMemory = 3072 },
                --             },
                --         },
                --     })
                --     return true -- บอก LazyVim ว่าเรา setup เองแล้ว (อย่าซ้ำ)
                -- end,

                eslint = function()
                    local lspconfig = require("lspconfig")
                    local capabilities = require("cmp_nvim_lsp").default_capabilities()
                    lspconfig.eslint.setup({
                        capabilities = capabilities,
                        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
                        settings = {
                            run = "onSave",
                            codeActionOnSave = { enable = true, mode = "all" },
                            format = false,
                            workingDirectories = { mode = "auto" },
                        },
                    })
                    return true
                end,
            },
        },
    },
    -- {
    --     "neovim/nvim-lspconfig",
    --     config = function()
    --         vim.diagnostic.config({
    --             underline = true,
    --             update_in_insert = false,
    --             severity_sort = true,
    --             signs = true,
    --             virtual_text = {
    --                 prefix = "●",
    --                 spacing = 2,
    --                 source = "if_many",
    --             },
    --         })
    --         -- (ทางเลือก) ปรับไอคอน sign
    --         local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    --         for name, icon in pairs(signs) do
    --             local hl = "DiagnosticSign" .. name
    --             vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    --         end
    --     end,
    -- },
}
