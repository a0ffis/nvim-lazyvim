return {
  -- NOTE: dracula
  {
      "Mofiqul/dracula.nvim",
      config = function()
          local dracula = require("dracula")
          dracula.setup({
              -- transparent_bg = true,
              colors = {
                  -- bg = "#282a36",
              },
          })
          vim.cmd.colorscheme("dracula")
      end,
  },
  -- NOTE: catppuccin
  -- { "catppuccin/nvim",         name = "catppuccin", priority = 1000 },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = { colorscheme = "catppuccin-macchiato" },
  -- },
  { 'akinsho/bufferline.nvim', version = "*",       dependencies = 'nvim-tree/nvim-web-devicons' }
}
