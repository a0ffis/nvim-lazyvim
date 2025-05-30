-- lspconfig.lua
return {
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
            -- คุณสามารถระบุ LSP ที่ต้องการติดตั้งอย่างชัดเจนได้ หากต้องการ
            -- ensure_installed = {
            --     "lua_ls",
            --     "ts_ls",
            --     "html",
            --     "gopls",
            --     "omnisharp",
            --     "dartls",
            --     "tailwindcss" -- ชื่อที่ lspconfig ใช้, mason จะติดตั้ง 'tailwindcss-language-server'
            -- }
        },
    },
    {
        lazy = false,
        "neovim/nvim-lspconfig",
        dependencies = {
            -- ตรวจสอบให้แน่ใจว่า plugin นี้ถูกโหลดก่อน หรือเป็น dependency
            -- หาก 'cmp_nvim_lsp' มาจาก plugin อื่นที่ไม่ได้ระบุไว้ที่นี่
            "hrsh7th/cmp-nvim-lsp", -- ตัวอย่าง plugin ที่ให้ 'cmp_nvim_lsp'
        },
        config = function()
            -- ตรวจสอบให้แน่ใจว่า `cmp_nvim_lsp` ถูก require อย่างถูกต้อง
            -- หาก 'cmp_nvim_lsp' มาจาก plugin อื่น ให้แน่ใจว่า plugin นั้นถูกโหลดแล้ว
            local capabilities
            local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            if not status_ok then
                vim.notify("cmp_nvim_lsp not found. LSP capabilities might be limited.", vim.log.levels.WARN)
                capabilities = {} -- fallback to empty capabilities
            else
                capabilities = cmp_nvim_lsp.default_capabilities()
            end

            local lspconfig = require("lspconfig")

            -- การตั้งค่า LSP อื่นๆ ของคุณ (ts_ls, html, lua_ls, gopls, omnisharp, dartls)
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.html.setup({
                capabilities = capabilities,
            })
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.gopls.setup({
                capabilities = capabilities,
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                    },
                },
            })

            -- หมายเหตุสำหรับ omnisharp:
            -- 1. ตรวจสอบว่า 'on_attach' function ถูก define ไว้ที่ไหนสักแห่งใน config ของคุณ หากไม่ได้ใช้ ให้ลบออก
            -- 2. 'cmd' ที่ระบุไว้นั้นเฉพาะเจาะจงมาก Mason อาจมีวิธีเรียกที่ทั่วไปกว่านี้
            --    แต่ถ้ามันทำงานได้ดีสำหรับคุณ ก็สามารถใช้ต่อไปได้
            local on_attach_custom -- = function(client, bufnr) ... end -- หากคุณมี on_attach แบบ custom
            lspconfig.omnisharp.setup({
                cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
                capabilities = capabilities,
                -- on_attach = on_attach_custom, -- หากคุณมี on_attach function ที่กำหนดไว้
                enable_ms_build_load_projects_on_demand = false,
                enable_editorconfig_support = true,
                enable_roslyn_analyzers = true,
                enable_import_completion = true,
                organize_imports_on_format = true,
                enable_decompilation_support = true,
                analyze_open_documents_only = false,
                root_dir = function(fname)
                    return lspconfig.util.root_pattern("*.sln", "*.csproj")(fname) or lspconfig.util.path.dirname(fname)
                end,
            })

            -- หมายเหตุสำหรับ dartls:
            -- คุณใช้ 'cmp_capabilities' ในโค้ดเดิม แต่ define 'capabilities' ด้านบน
            -- ที่นี่จะใช้ 'capabilities' ที่ define ไว้ด้านบนเพื่อความสอดคล้อง
            lspconfig.dartls.setup({
                capabilities = capabilities,
                cmd = { "dart", "language-server", "--protocol=lsp" },
                filetypes = { "dart" },
                init_options = {
                    closingLabels = true,
                    flutterOutline = true,
                    onlyAnalyzeProjectsWithOpenFiles = true,
                    outline = true,
                    suggestFromUnimportedLibraries = true,
                },
                settings = {
                    dart = {
                        completeFunctionCalls = true,
                        showTodos = true,
                        enableSdkFormatter = true,
                        flutterFormatOnSave = true,
                    },
                },
                -- on_attach = function(client, bufnr)
                -- Custom on_attach actions here if needed
                -- end,
            })

            -- ตั้งค่า Tailwind CSS LSP
            lspconfig.tailwindcss.setup({
                capabilities = capabilities,
                filetypes = {
                    "html",
                    "css",
                    "postcss",
                    "scss", -- เพิ่ม scss หากใช้ Tailwind กับ SCSS
                    "javascript",
                    "javascriptreact", -- สำหรับ JSX
                    "typescript",
                    "typescriptreact", -- สำหรับ TSX
                    "vue",
                    "svelte",
                    "astro",
                    "php",
                    "heex",
                    "elixir",
                    "eruby",
                    "razor",
                    "blade",
                    "twig",
                    -- เพิ่ม filetypes อื่นๆ ที่คุณใช้ Tailwind classes
                },
                -- สำหรับ Tailwind CSS v4, language server ควรจะตรวจจับเวอร์ชั่นได้เอง
                -- หากโปรเจกต์ของคุณติดตั้ง tailwindcss v4 และมีไฟล์ tailwind.config.js (หรือ .ts) ที่ถูกต้อง
                -- โดยทั่วไป ไม่จำเป็นต้องมีการตั้งค่าพิเศษสำหรับ v4 ใน lspconfig
                -- ตรวจสอบให้แน่ใจว่า `tailwindcss-language-server` ที่ติดตั้งผ่าน Mason เป็นเวอร์ชั่นล่าสุด
                init_options = {
                    userLanguages = {
                        -- ตัวอย่าง: หากคุณใช้ templating languages อื่นๆ
                        -- eex = "html-eex",
                        -- handlebars = "html",
                    },
                },
                -- การตั้งค่าเพิ่มเติม (ส่วนใหญ่ไม่จำเป็นสำหรับการใช้งานทั่วไป)
                -- settings = {
                --   ["tailwindcss-intellisense"] = {
                --     -- ดูเอกสารของ tailwindcss-language-server สำหรับ options ที่มี
                --     -- เช่น การระบุ path ไปยัง config file หากไม่ได้อยู่ใน root
                --     -- "tailwindCSS.experimental.configFile": "path/to/your/tailwind.config.js",
                --   }
                -- }
            })

            -- Keymaps สำหรับ LSP
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Definition" })
            vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP References" })
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
            -- เพิ่ม keymap อื่นๆ ตามต้องการ เช่น rename, format
            -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
            -- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "LSP Format" })
        end,
    },
}
