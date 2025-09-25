vim.g.mapleader = " "

-- Open file explorer
vim.keymap.set(
    "n",
    "<leader>pv",
    vim.cmd.Ex,
    { desc = "Open file explorer" }
)

-- Map Ctrl + Backspace to delete word in insert mode
vim.keymap.set("i", "<C-BS>", "<C-w>")

-- Map Tab and Shift + Tab to indenting and deindenting in visual mode
vim.keymap.set("v", "<S-Tab>", "<gv")
vim.keymap.set("v", "<Tab>", ">gv")

-- Move highlighted text with J nd K
vim.keymap.set("v", "J", ":m '> +1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '< -2<CR>gv=gv")

-- Half-page jump keeps cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Yank into system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Delete into system clipboard
vim.keymap.set("v", "<leader>d", "\"+d")
vim.keymap.set("n", "<leader>d", "\"+d")

vim.keymap.set("i", "<C-o>", function()
    local filetypes = { "c", "cpp", "h", "lua" }
    local current_ext = vim.fn.expand("%:e")
    -- Check if current filetype is in our list
    local should_add_backslash = false
    for _, ft in ipairs(filetypes) do
        if current_ext == ft then
            should_add_backslash = true
            break
        end
    end

    if should_add_backslash then
        local current_line = vim.api.nvim_get_current_line()
        vim.api.nvim_set_current_line(current_line .. " \\")
    end

    -- Insert actual newline
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
end, { silent = true })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = "Exit terminal mode" })

-- Close current tab with Ctrl+Q
vim.keymap.set("n", "<C-q>", ":tabclose<CR>", { desc = "Close current tab" })
