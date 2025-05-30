-- tailwind-tools.lua
return {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    -- build = ":UpdateRemotePlugins", -- 'build' command มักจะไม่จำเป็นสำหรับ plugin ส่วนใหญ่ที่เขียนด้วย Lua
    -- เว้นแต่ plugin นั้นต้องการขั้นตอนการ build พิเศษ
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim", -- optional
        "neovim/nvim-lspconfig", -- optional, แต่แนะนำเมื่อใช้ร่วมกับ tailwindcss lsp
    },
    opts = {}, -- your configuration, สามารถเพิ่ม options เฉพาะของ tailwind-tools ได้ที่นี่
    -- ตัวอย่างการตั้งค่าเพิ่มเติม (ถ้ามี):
    -- config = function(_, opts)
    --   require('tailwind-tools').setup(opts)
    -- end,
}
