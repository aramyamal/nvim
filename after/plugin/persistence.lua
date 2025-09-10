require("persistence").setup();

-- keybind to load
vim.keymap.set(
    "n", "<leader>ps", function() require("persistence").load() end,
    { desc = "Persistence: Load all previous sessions" }
)

-- load all sessions on startup after 200 ms delay to allow other plugins to
-- start. only restore session if launched by tmux-resurrect
if os.getenv("NVIM_TMUX_RESTORED") then
    vim.defer_fn(function()
        pcall(require("persistence").load)
    end, 200)
end
