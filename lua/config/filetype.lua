-- Vue filetype detection for Nuxt.js
vim.filetype.add({
  extension = {
    vue = "vue",
  },
  pattern = {
    [".*%.vue$"] = "vue",
  },
})