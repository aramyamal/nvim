vim.g.mapleader = " "

-- Open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Dark Theme gruvbox
vim.keymap.set("n", "<leader>dg", function()
    vim.o.background = "dark"
    vim.g.gruvbox_material_background = "hard"
    vim.cmd("colorscheme gruvbox-material")
    vim.cmd("silent !kitty +kitten themes --reload-in=all 'Gruvbox Material Dark Hard'")
    vim.cmd("silent !gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
    vim.cmd("silent !bash -c '$TMUX_DARK'")
end)

-- Light Theme gruvbox
vim.keymap.set("n", "<leader>lg", function()
    vim.o.background = "light"
    vim.g.gruvbox_material_background = "soft"
    vim.cmd("colorscheme gruvbox-material")
    vim.cmd("silent !kitty +kitten themes --reload-in=all 'Gruvbox Material Light Soft'")
    vim.cmd("silent !gsettings set org.gnome.desktop.interface color-scheme 'default'")
    vim.cmd("silent !bash -c '$TMUX_LIGHT'")
end)

-- Light Theme flexoki
vim.keymap.set("n", "<leader>lf", function()
    vim.cmd("colorscheme flexoki-light")
    vim.cmd("silent !kitty +kitten themes --reload-in=all 'Flexoki (Light)'")
    vim.cmd("silent !gsettings set org.gnome.desktop.interface color-scheme 'default'")
end)

-- Dark Theme flexoki
vim.keymap.set("n", "<leader>df", function()
    vim.cmd("colorscheme flexoki-dark")
    vim.cmd("silent !kitty +kitten themes --reload-in=all 'Flexoki (Dark)'")
    vim.cmd("silent !gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
end)

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
