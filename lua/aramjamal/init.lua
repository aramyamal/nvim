require("aramjamal.remap")
require("aramjamal.set")
require("aramjamal.pckr")

-- Automatically adjust theme of nvim according to system theme
local system_theme = vim.fn.system('get_theme_mode'):gsub('\n', '')
if system_theme == "dark" then
    vim.o.background = "dark"
    vim.cmd("colorscheme zenwritten")
else
    vim.o.background = "light"
    vim.cmd("colorscheme zenwritten")
end
