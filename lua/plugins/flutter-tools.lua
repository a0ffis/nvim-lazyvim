return {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    opts = {
        ui = {
            border = "rounded",
            notification_style = "native", -- หรือ "plugin"
        },
        decorations = {
            statusline = {
                app_version = false,
                device = false,
                project_config = false,
            },
        },
        debugger = {
            enabled = false,
            exception_breakpoints = {},
            evaluate_to_string_in_debug_views = true,
        },
        -- flutter_path = "<full/path/if/needed>", -- ให้คอมเมนต์ออกหากไม่จำเป็น
        flutter_lookup_cmd = nil,
        root_patterns = { ".git", "pubspec.yaml" },
        fvm = false,
        widget_guides = {
            enabled = true,
        },
        closing_tags = {
            highlight = "ErrorMsg",
            prefix = ">",
            priority = 10,
            enabled = true,
        },
        dev_log = {
            enabled = true,
            notify_errors = false,
            open_cmd = "15split",
            focus_on_open = true,
        },
        dev_tools = {
            autostart = false,
            auto_open_browser = false,
        },
        outline = {
            open_cmd = "30vnew",
            auto_open = false,
        },
        lsp = {
            color = {
                enabled = true,
                background = false,
                background_color = nil,
                foreground = false,
                virtual_text = true,
                virtual_text_str = "■",
            },
            -- ต้องการปรับแต่ง on_attach? ให้ใช้ข้างล่างนี้
            -- on_attach = function(client, bufnr)
            --   -- ใส่โค้ด on_attach ที่นี่
            --   -- หรือเรียกใช้ฟังก์ชันอื่น
            -- end,
            --
            -- capabilities = ... -- สามารถระบุ capabilities ได้ที่นี่
            settings = {
                showTodos = true,
                completeFunctionCalls = true,
                -- analysisExcludedFolders = {"<path-to-flutter-sdk-packages>"},
                renameFilesWithClasses = "prompt", -- หรือ "always"
                enableSnippets = true,
                updateImportsOnRename = true,
            },
        },
    },
    config = function(_, opts)
        require("flutter-tools").setup(opts)
        vim.keymap.set("n", "<leader>Fr", "<cmd>FlutterRun<CR>", { desc = "Flutter: Run" })
        vim.keymap.set("n", "<leader>Fq", "<cmd>FlutterQuit<CR>", { desc = "Flutter: Quit" })
        vim.keymap.set("n", "<leader>Fh", "<cmd>FlutterReload<CR>", { desc = "Flutter: Hot Reload" })
        vim.keymap.set("n", "<leader>FR", "<cmd>FlutterRestart<CR>", { desc = "Flutter: Hot Restart" })
        vim.keymap.set("n", "<leader>Fl", "<cmd>FlutterLog<CR>", { desc = "Flutter: Dev Log" })
        vim.keymap.set("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<CR>", { desc = "Flutter: Outline" })
        vim.keymap.set("n", "<leader>Fw", "<cmd>FlutterWidgetGuidesToggle<CR>", { desc = "Flutter: Widget Guide" })
        vim.keymap.set("n", "<leader>Fe", "<cmd>FlutterEmulators<CR>", { desc = "Flutter: Emulators" })
    end,
}
