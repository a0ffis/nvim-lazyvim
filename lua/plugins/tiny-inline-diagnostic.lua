-- lua/plugins/tiny-inline-diagnostic.lua
return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "LspAttach", -- หรือ "VeryLazy"
        priority = 1000, -- ให้โหลดก่อนเพื่อชนะธีม/สีอื่น
        config = function()
            require("tiny-inline-diagnostic").setup({
                preset = "ghost", -- ลอง "classic" | "minimal" | "powerline" | "ghost" ฯลฯ
                transparent_bg = false,
                hi = {
                    -- ใช้ group มาตรฐานของ nvim diagnostic
                    error = "DiagnosticError",
                    warn = "DiagnosticWarn",
                    info = "DiagnosticInfo",
                    hint = "DiagnosticHint",
                    background = "CursorLine",
                    mixing_color = "None",
                },
                options = {
                    show_source = { enabled = false, if_many = false },
                    use_icons_from_diagnostic = false,
                    set_arrow_to_diag_color = false,
                    add_messages = true,
                    throttle = 50, -- ถ้ากระตุกเพิ่มเป็น 50–80
                    softwrap = 30,
                    multilines = { enabled = false, always_show = false },
                    show_all_diags_on_cursorline = true,
                    enable_on_insert = false, -- ถ้าอยากเห็นตอน Insert ให้เปิด true
                    enable_on_select = false,
                    overflow = { mode = "wrap", padding = 0 },
                    break_line = { enabled = false, after = 30 },
                    format = nil, -- ใส่ฟังก์ชันแปลงข้อความเองได้
                    virt_texts = { priority = 2048 }, -- ถ้าเจอ GitBlame แทรก ให้เพิ่มค่านี้
                    severity = { -- กรองระดับที่อยากโชว์
                        vim.diagnostic.severity.ERROR,
                        vim.diagnostic.severity.WARN,
                        vim.diagnostic.severity.INFO,
                        vim.diagnostic.severity.HINT,
                    },
                    overwrite_events = { "BufEnter", "DiagnosticChanged", "CursorHold", "CursorMoved" },
                },
                disabled_ft = {}, -- รายชื่อ filetype ที่อยากปิดปลั๊กอินนี้
            })

            -- สำคัญ: ปิด virtual_text เดิม ไม่งั้นจะซ้อนกัน
            vim.diagnostic.config({ virtual_text = false })
        end,
    },
}
