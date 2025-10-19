require("toggleterm").setup({
    shade_terminals = false,
})

local opts = { noremap = true, silent = true }

-- Main toggle terminal
vim.keymap.set('n', '<leader>tm', '<cmd>ToggleTerm<cr>',
    vim.tbl_extend('force', opts, { desc = 'ToggleTerm: Toggle terminal' }))

-- Terminal management
vim.keymap.set('n', '<leader>ta', '<cmd>ToggleTermToggleAll<cr>',
    vim.tbl_extend('force', opts, { desc = 'ToggleTerm: Toggle all terminals' }))
vim.keymap.set('n', '<leader>tn', '<cmd>TermNew<cr>',
    vim.tbl_extend('force', opts, { desc = 'ToggleTerm: Create new terminal' }))
vim.keymap.set('n', '<leader>ts', '<cmd>TermSelect<cr>',
    vim.tbl_extend('force', opts, { desc = 'ToggleTerm: Select terminal' }))
vim.keymap.set('n', '<leader>tr', '<cmd>ToggleTermSetName<cr>',
    vim.tbl_extend('force', opts, { desc = 'ToggleTerm: Rename terminal' }))

vim.keymap.set('t', '<C-k>', '<Cmd>wincmd k<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-h>', '<Cmd>wincmd h<CR>', { noremap = true, silent = true })
