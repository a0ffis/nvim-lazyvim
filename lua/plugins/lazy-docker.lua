return {
    "mgierada/lazydocker.nvim",
    dependencies = { "akinsho/toggleterm.nvim" },
    config = function()
        require("toggleterm").setup({
            -- size = 20,
            -- open_mapping = [[<c-\>]],
            -- hide_numbers = true,
            -- shade_filetypes = {},
            -- shade_terminals = true,
            -- shading_factor = 2,
            -- start_in_insert = true,
            -- insert_mappings = true,
            -- terminal_mappings = true,
            -- persist_size = true,
            -- direction = "float", -- Use floating terminal
            -- float_opts = {
            --     border = "curved",
            --     winblend = 3,
            -- },
        })

        -- Command for Lazydocker
        vim.api.nvim_set_keymap(
            "n",
            "<leader>ld",
            [[<cmd>lua require("toggleterm.terminal").Terminal:new({ cmd = "lazydocker", direction = "float" }):toggle()<CR>]],
            { noremap = true, silent = true, desc = "Lazydocker" }
        )
    end,
}
