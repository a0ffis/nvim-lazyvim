return {
  -- NOTE: dracula
  -- {
  --     "Mofiqul/dracula.nvim",
  --     config = function()
  --         local dracula = require("dracula")
  --         dracula.setup({
  --             -- transparent_bg = true,
  --             colors = {
  --                 -- bg = "#282a36",
  --             },
  --         })
  --         vim.cmd.colorscheme("dracula")
  --     end,
  -- },
  -- NOTE: catppuccin
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 10000,
    init = function()
      local ok, ctp = pcall(require, "catppuccin.groups.integrations.bufferline")
      if ok and ctp and not ctp.get and ctp.get_theme then
        -- สร้าง alias ให้ LazyVim ที่ยังเรียก get() ใช้ได้
        ctp.get = ctp.get_theme
      end
    end,
    config = function()
      -- require("catppuccin").setup({
      --   integrations = { bufferline = true, treesitter = true, cmp = true },
      -- })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- {
  --   "akinsho/bufferline.nvim",
  --   -- ของคุณจะยังคงใช้ get_theme() ได้ตามปกติ
  --   config = function()
  --     local ctp = require("catppuccin.groups.integrations.bufferline")
  --     require("bufferline").setup({
  --       highlights = ctp.get_theme(),
  --       options = {
  --         -- separator_style = "slant",
  --         -- diagnostics = "nvim_lsp",
  --         -- show_buffer_close_icons = false,
  --         -- show_close_icon = false,
  --       },
  --     })
  --   end,
  -- },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-macchiato" },
  },
}
