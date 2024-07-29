vim.g.mapleader = " "

-- Open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Light Theme
vim.keymap.set("n", "<leader>ll", function()
	vim.cmd("colorscheme flexoki-light")
	vim.cmd("silent !kitty +kitten themes --reload-in=all 'Flexoki (Light)'")
end)

-- Dark Theme
vim.keymap.set("n", "<leader>dd", function()
	vim.cmd("colorscheme flexoki-dark")
	vim.cmd("silent !kitty +kitten themes --reload-in=all 'Flexoki (Dark)'")
end)

-- Map Ctrl + Backspace to delete word in insert mode
vim.keymap.set("i", "<C-BS>", "<C-w>")

-- Map Tab and Shift + Tab to indenting and deintenting in visual mode
vim.keymap.set("v", "<S-Tab>", "<gv")
vim.keymap.set("v", "<Tab>", ">gv")

-- Move highlighted text
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
vim.keymap.set("n", "<leader>d", "\"+d")
vim.keymap.set("v", "<leader>d", "\"+d")
