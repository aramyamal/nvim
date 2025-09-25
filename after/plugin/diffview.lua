-- Diffview toggle function
local function toggle_diffview()
    -- Check if Diffview is currently open
    local view = require("diffview.lib").get_current_view()

    if view then
        -- If open → close it
        vim.cmd("DiffviewClose")
    else
        -- If closed → open it
        vim.cmd("DiffviewOpen")
    end
end

-- Keymap
vim.keymap.set(
    "n",
    "<leader>dv",
    toggle_diffview,
    { desc = "Diffview: Toggle diff view open/close" }
)

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- Open Diffview against another file, without sidebar
local function diff_with_current_file()
  require("telescope.builtin").find_files({
    prompt_title = "Select file to diff against your current one", -- ★ Custom label
    attach_mappings = function(_, map)
      local function open_diff(prompt_bufnr)
        local selection = require("telescope.actions.state").get_selected_entry()
        require("telescope.actions").close(prompt_bufnr)

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

        -- Open Diffview with both files
        vim.cmd("DiffviewOpen -- " .. current_file .. " " .. target_file)

        -- Close the sidebar only for this case
        local lib = require("diffview.lib")
        local view = lib.get_current_view()
        if view and view.panel then
          view.panel:close()
        end
      end

      map("i", "<CR>", open_diff)
      map("n", "<CR>", open_diff)
      return true
    end,
  })
end

-- Keymap for diff-with-file (no sidebar)
vim.keymap.set(
  "n",
  "<leader>df",
  diff_with_current_file,
  { desc = "Diff current file against another (no sidebar)" }
)
