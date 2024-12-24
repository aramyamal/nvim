require("aramjamal.remap")
require("aramjamal.set")
-- Automatically adjust theme of terminal and nvim according to system theme
if vim.fn.system('gsettings get org.gnome.desktop.interface color-scheme'):gsub('\n', '') == "'default'" then
    vim.o.background = "light"
    vim.g.gruvbox_material_background = "medium"
    vim.cmd("colorscheme gruvbox-material")
    vim.cmd("silent !kitty +kitten themes --reload-in=all 'Gruvbox Material Light Hard'")
else
    vim.o.background = "dark"
    vim.g.gruvbox_material_background = "hard"
    vim.cmd("colorscheme gruvbox-material")
    vim.cmd("silent !kitty +kitten themes --reload-in=all 'Gruvbox Material Dark Hard'")
end
