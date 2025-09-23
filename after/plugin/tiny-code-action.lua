require("tiny-code-action").setup({
    -- The picker to use - choose one of the options below

    -- Option 1: Telescope (default, requires telescope.nvim)
    -- picker = "telescope",

    -- Option 2: Buffer picker (minimal, built-in)
    -- picker = "buffer",

    -- Option 3: Vim's built-in ui.select
    -- picker = "select",

    -- Option 4: Snacks picker (requires snacks.nvim)
    -- picker = "snacks",

    -- Option 5: FZF-Lua picker (requires fzf-lua)
    -- picker = "fzf-lua",

    -- Advanced buffer picker configuration with options
    picker = {
        "buffer",
        opts = {
            hotkeys = true,                   -- Enable hotkeys (a,b,c...) for quick selection
            hotkeys_mode = "text_diff_based", -- "sequential", "text_based", "text_diff_based"
            auto_preview = true,              -- Automatically preview selected action
            auto_accept = true,               -- Automatically accept selected action
            position = "cursor",              -- Position of picker window
            winborder = "double",             -- Border style: "single", "double", "rounded", etc.
            -- custom_keys = {
            --     { key = 'm', pattern = 'Fill match arms' },
            --     { key = 'r', pattern = 'Rename.*' },  -- Lua pattern matching
            --     { key = 'e', pattern = 'Extract Method' },
            -- },
        },
    },
})

vim.keymap.set(
    { "n", "x" },
    "<leader>ca",
    function()
        require("tiny-code-action").code_action()
    end,
    { desc = "tiny-code-action: Show code actions", noremap = true, silent = true }
)

vim.keymap.set(
    { "n", "x" },
    "<F4>",
    function()
        require("tiny-code-action").code_action()
    end,
    { desc = "tiny-code-action: Show code actions", noremap = true, silent = true }
)
