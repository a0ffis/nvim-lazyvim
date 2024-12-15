return {
    "amitds1997/remote-nvim.nvim",
    version = "*", -- Pin to GitHub releases
    dependencies = {
        "nvim-lua/plenary.nvim", -- For standard functions
        "MunifTanjim/nui.nvim", -- To build the plugin UI
        "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    config = function()
        require("remote-nvim").setup({
            -- Define your connection configurations here if needed
        })

        -- Key mappings for Remote commands
        vim.keymap.set("n", "<leader>rc", ":RemoteStart<CR>", { desc = "Connect Remote Neovim" })
        vim.keymap.set("n", "<leader>rs", ":RemoteStop<CR>", { desc = "Stop Remote Neovim" })
        -- vim.keymap.set("n", "<leader>ri", ":RemoteInfo<CR>", { desc = "Show Remote Session Info" })
        -- vim.keymap.set("n", "<leader>rc", ":RemoteCleanup<CR>", { desc = "Cleanup Remote Workspace" })
        -- vim.keymap.set("n", "<leader>rd", ":RemoteConfigDel<CR>", { desc = "Delete Remote Config" })
        vim.keymap.set("n", "<leader>rl", ":RemoteLog<CR>", { desc = "Open Remote Plugin Log" })
    end,
}
