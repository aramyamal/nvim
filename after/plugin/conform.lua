require("conform").setup({
    formatters_by_ft = {
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        markdown = { "prettierd", "prettier", stop_after_first = true },
        c = { "comment_pragma_omp", "clang-format", "uncomment_pragma_omp" },
        -- lean = { "leanfmt" },
        tex = { "tex-fmt" },
    },
    formatters = {
        comment_pragma_omp = {
            command = "sed",
            args = { "-i", "s/#pragma omp/\\/\\/\\/#pragma omp/g", "$FILENAME" },
            stdin = false, -- we're modifying the file in-place
        },
        uncomment_pragma_omp = {
            command = "sed",
            args = { "-i", "s/\\/\\/\\/ *#pragma omp/#pragma omp/g", "$FILENAME" },
            stdin = false,
        },

        -- leanfmt = {
        --     command = "lean",
        --     args = { "--run", "fmt", "$FILENAME" },
        --     stdin = false,
        -- },
    }
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.md", "*.c" --[[ , "*.lean" ]] },
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})

vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
        }
    end
    require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })
