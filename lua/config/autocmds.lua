-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function check_and_remove_terminators()
    -- ตรวจสอบว่ามี unusual terminators หรือไม่
    local has_ls = vim.fn.search([[\%u2028]], "n") > 0
    local has_ps = vim.fn.search([[\%u2029]], "n") > 0

    -- ถ้าพบ unusual terminators
    if has_ls or has_ps then
        local filename = vim.fn.expand("%:t")
        local message = string.format(
            "The file '%s' contains unusual line terminator characters (LS or PS). Would you like to remove them?",
            filename
        )

        -- สร้าง prompt ให้ผู้ใช้เลือก
        vim.ui.select({ "Yes", "No" }, {
            prompt = message,
            format_item = function(item)
                return item
            end,
        }, function(choice)
            if choice == "Yes" then
                -- เก็บตำแหน่ง cursor ปัจจุบัน
                local cur_pos = vim.fn.getcurpos()

                -- ลบ Line Separator และ Paragraph Separator
                vim.cmd([[silent! %s/\%u2028//g]])
                vim.cmd([[silent! %s/\%u2029//g]])

                -- คืนตำแหน่ง cursor กลับไปที่เดิม
                vim.fn.setpos(".", cur_pos)

                -- แจ้งเตือนว่าลบสำเร็จ
                vim.notify("Unusual line terminators have been removed", vim.log.levels.INFO)
            end
        end)
    end
end

-- สร้าง autocmd สำหรับตรวจสอบไฟล์
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePre" }, {
    pattern = {
        "*.tsx",
        "*.jsx",
        "*.ts",
        "*.js",
        "*.vue",
        "*.svelte",
        "*.html",
        "*.css",
        "*.md",
        "*.txt",
        "*.json",
        "*.yaml",
        "*.yml",
        "*.conf",
        "*.xml",
        "*.toml",
        "*.dart",
        "*.php",
    },
    callback = function(ev)
        check_and_remove_terminators()
    end,
})

-- เพิ่มคำสั่งสำหรับเรียกใช้งานด้วยตนเอง
vim.api.nvim_create_user_command("RemoveUnusualTerminators", function()
    check_and_remove_terminators()
end, {})
