vim.g.mapleader = " "
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
