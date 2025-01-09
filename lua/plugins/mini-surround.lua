return {
    {
        "echasnovski/mini.surround",
        version = "*", -- Automatically fetch the latest stable version
        config = function()
            require("mini.surround").setup() -- Default configuration
        end,
    },
}
