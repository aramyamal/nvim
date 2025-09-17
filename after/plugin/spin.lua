require("spin").setup({
    check_on_save = true,             -- Run check on file save
    check_on_insert_leave = true,     -- Run check when leaving insert mode
    generate_command = "spin -a",     -- Command to generate verifier
    trail_command = "spin -t -p -l",  -- Command to follow simulation trail
    gcc_command = "gcc -o pan pan.c", -- Command to compile verifier
    on_attach = function(client, bufnr)
        -- Set keybindings, etc. here
        -- bind `K` to hover
        vim.keymap.set("n", "K", vim.lsp.buf.hover)
    end,
})
