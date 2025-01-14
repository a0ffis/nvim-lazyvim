-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.clipboard = "unnamedplus"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.api.nvim_set_keymap(
    "n",
    "<leader>ru",
    '<cmd>lua print("Organizing and removing unused imports...")<CR><cmd>lua vim.lsp.buf.code_action({context = {only = {"source.organizeImports"}}, apply = true})<CR><cmd>lua vim.lsp.buf.code_action({context = {only = {"source.removeUnusedImports"}}, apply = true})<CR>',
    { noremap = true, silent = true }
)

-- vim.api.nvim_set_keymap(
--     "n",
--     "<leader>ru",
--     '<cmd>lua print("Organizing imports...")<CR><cmd>lua vim.lsp.buf.code_action({context = {only = {"source.organizeImports"}}, apply = true})<CR>',
--     { noremap = true, silent = true }
-- )
--
-- vim.api.nvim_set_keymap(
--     "n",
--     "<leader>ru",
--     '<cmd>lua print("Organizing imports...")<CR><cmd>lua vim.lsp.buf.code_action({context = {only = {"source.removeUnusedImports"}}, apply = true})<CR>',
--     { noremap = true, silent = true }
-- )

-- vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
-- vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
-- vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
-- vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })
