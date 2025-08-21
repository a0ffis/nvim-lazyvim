return {
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            local builtins = null_ls.builtins

            null_ls.setup({
                -- debug = true, -- เปิดหากต้องการ debug
                sources = {
                    -- 📜 Lua
                    builtins.formatting.stylua, -- คุณมี stylua ติดตั้งแล้ว

                    -- 🐘 PHP (Laravel)
                    -- Formatter: คุณมี pint และ php-cs-fixer. pint เหมาะกับ Laravel มากกว่า
                    builtins.formatting.pint, -- (คุณมี pint ติดตั้งแล้ว)
                    -- builtins.formatting.php_cs_fixer, -- (คุณมี php-cs-fixer ติดตั้งแล้ว, เลือกใช้ตัวใดตัวหนึ่ง)
                    -- Linter:
                    builtins.diagnostics.phpcs, -- (คุณมี phpcs ติดตั้งแล้ว)
                    -- หากต้องการ linter ที่เข้มข้นขึ้น อาจพิจารณา phpstan (ต้อง :MasonInstall phpstan)

                    -- 🌐 JavaScript / TypeScript (Next.js, NestJS)
                    builtins.formatting.prettierd, -- (คุณมี prettierd ติดตั้งแล้ว)
                    -- builtins.diagnostics.eslint_d, -- (คุณมี eslint_d ติดตั้งแล้ว)
                    -- หมายเหตุ: คุณมี eslint-lsp ด้วย ซึ่งเป็น LSP,
                    -- eslint_d มักจะเร็วกว่าสำหรับ linting ผ่าน none-ls.
                    -- หากใช้ eslint_d ที่นี่ อาจจะไม่จำเป็นต้องเปิด eslint_lsp

                    -- 🐦 Dart (Flutter)
                    -- เครื่องมือ Dart มักจะมากับ Dart SDK และไม่ได้ติดตั้งผ่าน Mason โดยตรง
                    -- builtins.formatting.dart_format, -- หาก Dart SDK อยู่ใน PATH
                    -- builtins.diagnostics.dart_analyze, -- หาก Dart SDK อยู่ใน PATH
                    -- Dart LSP (ถ้ามี) อาจจะจัดการส่วนนี้ได้ดีอยู่แล้ว

                    -- 🐹 Go
                    -- Formatter: คุณมี gofumpt และ goimports. goimports จัดการ imports ด้วย
                    builtins.formatting.goimports, -- (คุณมี goimports ติดตั้งแล้ว)
                    -- builtins.formatting.gofumpt,    -- (คุณมี gofumpt ติดตั้งแล้ว, เป็นอีกทางเลือก)
                    -- Linter: gopls (ที่คุณมี) เป็น LSP หลักสำหรับ Go และจัดการ linting ได้ดีมาก
                    -- หากต้องการ linter แยกต่างหากที่ทรงพลัง อาจพิจารณา golangci-lint (:MasonInstall golangci-lint)
                    -- builtins.diagnostics.golangci_lint,
                    -- Code Actions:
                    builtins.code_actions.gomodifytags, -- (คุณมี gomodifytags ติดตั้งแล้ว)
                    builtins.code_actions.impl, -- (คุณมี impl ติดตั้งแล้ว)

                    -- 🐍 Python
                    builtins.formatting.black, -- (คุณมี black ติดตั้งแล้ว)
                    builtins.formatting.isort, -- (คุณมี isort ติดตั้งแล้ว, สำหรับจัดเรียง imports)
                    -- หากต้องการ linter ที่ครอบคลุมและเร็วมาก อาจพิจารณา ruff (:MasonInstall ruff)
                    -- builtins.diagnostics.ruff,
                    -- builtins.formatting.ruff_format, -- ruff สามารถ format ได้ด้วย

                    -- 🐚 Shell
                    builtins.formatting.shfmt, -- (คุณมี shfmt ติดตั้งแล้ว)
                    -- builtins.diagnostics.shellcheck, -- (แนะนำ :MasonInstall shellcheck สำหรับ linting shell scripts)

                    -- 🐳 Dockerfile
                    builtins.diagnostics.hadolint, -- (คุณมี hadolint ติดตั้งแล้ว)

                    --  M️⃣ Markdown
                    builtins.diagnostics.markdownlint, -- (น่าจะใช้ markdownlint-cli2 ที่คุณมี)
                    -- builtins.formatting.prettierd, -- prettierd ก็สามารถ format markdown ได้

                    -- 💾 SQL
                    -- builtins.formatting.sqlfluff_fix, -- (คุณมี sqlfluff ติดตั้งแล้ว)
                    -- builtins.diagnostics.sqlfluff_lint, -- (คุณมี sqlfluff ติดตั้งแล้ว)
                },
                -- on_attach = function(client, bufnr)
                --   if client.supports_method("textDocument/formatting") then
                --     vim.api.nvim_create_autocmd("BufWritePre", {
                --       group = vim.api.nvim_create_augroup("NlsFormat", { clear = true }),
                --       buffer = bufnr,
                --       callback = function()
                --         vim.lsp.buf.format({ bufnr = bufnr, async = false, timeout_ms = 5000 })
                --       end,
                --     })
                --   end
                -- end,
            })
        end,
    },
}
