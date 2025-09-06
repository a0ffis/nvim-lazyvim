  -- 🔁 blink.cmp
return  {
    "saghen/blink.cmp",
    lazy = false,
    version = "*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      -- ✅ keymap ตามที่ขอ
      keymap = {
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },

        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-j>"] = { "select_next", "fallback_to_mappings" },
      },

      -- ✅ แก้ selection ให้เป็น table (ไม่ใช่ string)
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = true },
      },

      snippets = { preset = "default" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        -- ถ้าใช้ copilot และขึ้นซ้ำ 2 อัน ให้ลบ/ปิด copilot-cmp แล้วเพิ่ม/ลบ "copilot" ที่นี่ตามต้องการ
        -- default = { "lsp", "path", "snippets", "buffer", "copilot" },
      },
      signature = { enabled = true },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
    },
  }
