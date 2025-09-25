local peek = require("peek")
local system_theme = vim.fn.system('get_theme_mode'):gsub('\n', '')
if system_theme ~= "dark" then
    system_theme = "light"
end

peek.setup({
    auto_load = true,        -- whether to automatically load preview when
    -- entering another markdown buffer
    close_on_bdelete = true, -- close preview window on buffer delete

    syntax = true,           -- enable syntax highlighting, affects performance

    theme = system_theme,    -- 'dark' or 'light'

    update_on_change = true,

    app = 'webview', -- 'webview', 'browser', string or a table of strings
    -- explained below

    filetype = { 'markdown' }, -- list of filetypes to recognize as markdown

    -- relevant if update_on_change is true
    throttle_at = 200000,   -- start throttling when file exceeds this
    -- amount of bytes in size
    throttle_time = 'auto', -- minimum amount of time in milliseconds
    -- that has to pass before starting new render
})

vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
vim.api.nvim_create_user_command("PeekClose", peek.close, {})

vim.keymap.set('n', '<leader>mD', ':PeekOpen<CR>', {
    silent = true,
    noremap = true,
    desc = 'Peek: Open Markdown preview'
})


local auto_preview = false
-- function to toggle the auto-markdown-preview feature
local function toggle_markdown_preview()
    if auto_preview then
        -- disable auto-follow
        auto_preview = false
        if peek.is_open() then
            peek.close()
        end
        vim.notify("Auto Markdown Preview: OFF", vim.log.levels.INFO)
    else
        -- enable auto-follow
        auto_preview = true
        -- open if currently in markdown
        if vim.bo.filetype == "markdown" and not peek.is_open() then
            peek.open()
        end
        vim.notify("Auto Markdown Preview: ON", vim.log.levels.INFO)
    end
end

-- autocmd to handle buffer switching
vim.api.nvim_create_augroup("PeekAutoPreview", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
    group = "PeekAutoPreview",
    callback = function()
        if not auto_preview then
            return
        end
        if vim.bo.filetype == "markdown" then
            if not peek.is_open() then
                peek.open()
            end
        else
            if peek.is_open() then
                peek.close()
            end
        end
    end,
})

-- map the toggle function
vim.api.nvim_create_user_command("PeekToggleAuto", toggle_markdown_preview, {})
vim.keymap.set("n", "<leader>md", toggle_markdown_preview, {
    silent = true,
    noremap = true,
    desc = "Peek: Toggle auto markdown preview (follow buffers)",
})
