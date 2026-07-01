require("mdmath").setup({})

local function get_comment_block(cursor)
    local buf_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local total = #buf_lines

    local function is_comment(lnum)
        if lnum < 1 or lnum > total then return false end
        return buf_lines[lnum]:match("^%s*//") ~= nil
    end

    local top = cursor
    while is_comment(top - 1) do
        top = top - 1
    end

    local bot = cursor
    while is_comment(bot + 1) do
        bot = bot + 1
    end

    return vim.api.nvim_buf_get_lines(0, top - 1, bot, false)
end

local function get_latex_math_block()
    local ok, parser = pcall(vim.treesitter.get_parser, 0, "latex")
    if not ok or not parser then
        return nil
    end

    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1] - 1, cursor[2]

    local tree = parser:parse()[1]
    local root = tree:root()

    local target_types = {
        inline_formula = true,
        displayed_equation = true,
        math_environment = true,
    }

    local node = root:named_descendant_for_range(row, col, row, col)
    while node do
        if target_types[node:type()] then
            break
        end
        node = node:parent()
    end

    if not node then
        return nil
    end

    local start_row, start_col, end_row, end_col = node:range()
    local lines = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})

    -- Strip outer delimiters so mdmath/markdown gets clean $ or $$ syntax
    local text = table.concat(lines, "\n")

    local node_type = node:type()
    if node_type == "inline_formula" then
        -- \(...\)  or  $...$  -> normalize to $...$
        text = text:gsub("^\\%(", ""):gsub("\\%)$", "")
        text = text:gsub("^%$", ""):gsub("%$$", "")
        text = "$" .. text .. "$"
    elseif node_type == "displayed_equation" then
        -- \[...\]  or  $$...$$  -> normalize to $$...$$
        text = text:gsub("^\\%[", ""):gsub("\\%]$", "")
        text = text:gsub("^%$%$", ""):gsub("%$%$$", "")
        text = "$$" .. text .. "$$"
    elseif node_type == "math_environment" then
        -- \begin{align}...\end{align} etc -> wrap whole thing in $$ ... $$
        text = "$$\n" .. text .. "\n$$"
    end

    return vim.split(text, "\n")
end

local function show_preview(lines)
    local stripped = vim.tbl_map(function(line)
        return line:gsub("^%s*///?%s?", "")
    end, lines)

    table.insert(stripped, 1, "")

    local width = math.floor(vim.o.columns * 0.9)
    local height = math.min(#stripped + 2, vim.o.lines - 4)

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, stripped)
    vim.bo[buf].filetype = "markdown"
    vim.bo[buf].bufhidden = "wipe"

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor((vim.o.lines - height) / 2),
        style = "minimal",
        border = "rounded",
        title = " Math Preview ",
        title_pos = "center",
    })

    vim.api.nvim_win_set_cursor(win, { 1, 0 })

    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
    vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf, silent = true })
end

vim.api.nvim_create_user_command("MathPreview", function(opts)
    local lines

    if opts.range > 0 then
        lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
    elseif vim.bo.filetype == "tex" then
        lines = get_latex_math_block()
        if not lines then
            vim.notify("No LaTeX math environment found under cursor", vim.log.levels.WARN)
            return
        end
    else
        local cursor = vim.api.nvim_win_get_cursor(0)[1]
        lines = get_comment_block(cursor)
    end

    show_preview(lines)
end, { range = true })

vim.keymap.set("v", "<leader>mp", ":MathPreview<cr>", { silent = true })
vim.keymap.set("n", "<leader>mp", "<cmd>MathPreview<cr>", { silent = true })
