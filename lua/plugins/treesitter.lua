return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "vue",
      "typescript",
      "javascript",
      "html",
      "css",
      "scss",
      "json",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
  },
}