require("conform").setup({
    formatters_by_ft = {
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        markdown = { "prettierd", "prettier", stop_after_first = true },
        c = { "comment_pragma_omp", "clang-format", "uncomment_pragma_omp" },
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
    }
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.md", "*.c" },
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
