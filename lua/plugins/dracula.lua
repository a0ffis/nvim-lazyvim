return {
  "Mofiqul/dracula.nvim",
  config = function()
    local dracula = require("dracula")
    dracula.setup({
      transparent_bg = true,
      colors = {
        bg = "#282a36",
      }
    })
    vim.cmd.colorscheme "dracula"
  end,
}
