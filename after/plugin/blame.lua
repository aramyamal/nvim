require("blame").setup({
    commit_detail_view = function(commit_hash, row, file_path)
        local lib = require("diffview.lib")

        -- Normalize file path (relative to repo root)
        local rel_path = vim.fn.fnamemodify(file_path, ":.")

        -- Open Diffview for just that commit and file
        vim.cmd("DiffviewOpen " .. commit_hash .. "^! -- " .. rel_path)

        -- Close sidebar
        local lib = require("diffview.lib")
        local view = lib.get_current_view()
        if view and view.panel then
            view.panel:close()
        end
    end,
})

vim.keymap.set("n", "<leader>gb", vim.cmd.BlameToggle, { desc = "Git Blame (blame.nvim)" })
