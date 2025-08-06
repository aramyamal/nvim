require('blame').setup {}

vim.keymap.set("n", "<leader>gB", vim.cmd.BlameToggle, { desc = "Git Blame" })
