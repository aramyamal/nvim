local builtin = require('telescope.builtin')
vim.keymap.set(
    'n',
    '<leader>ff',
    builtin.find_files,
    { desc = "Telescope: Find Files" }
)

vim.keymap.set(
    'n',
    '<leader>fh',
    builtin.git_files,
    { desc = "Telescope: Find Git Files" }
)

vim.keymap.set(
    'n',
    '<leader>fg',
    builtin.live_grep,
    { desc = "Telescope: Live Grep" }
)

vim.keymap.set(
    'n',
    '<leader>fc',
    function()
        require('telescope.builtin').find_files({
            cwd = '~/.config/nvim'
        })
    end,
    { desc = "Telescope: Find Config Files" }
)

-- Map ? to Telescope keymaps
vim.keymap.set('n', '?', builtin.keymaps, { desc = "Telescope Keymaps" })

local actions = require("telescope.actions")
local telescope = require("telescope")

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
            }
        }
    }
}

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- Diff current file against another picked from Telescope
local function diff_with_current_file()
    builtin.find_files({
        prompt_title = "Select file to diff against your current one",
        attach_mappings = function(_, map)
            local function open_diff(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                if not selection then
                    print("No file selected")
                    return
                end

                local current_file = vim.fn.expand("%:p")
                local target_file = selection.path or selection.filename

                if current_file == "" then
                    print("No current file to diff against")
                    return
                end

                -- Open a new tab with diff between the two files
                vim.cmd("tabnew " .. target_file)  -- open the chosen file in a new tab
                vim.cmd("vert diffsplit " .. current_file) -- vertical diff split with current file
            end

            map("i", "<CR>", open_diff)
            map("n", "<CR>", open_diff)
            return true
        end,
    })
end

-- Keymap for diff-with-file
vim.keymap.set(
    "n",
    "<leader>df",
    diff_with_current_file,
    { desc = "Diff current file against another file (native diffsplit)" }
)
