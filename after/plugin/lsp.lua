local lsp_zero = require('lsp-zero')

-- auto format on save / write
vim.api.nvim_create_augroup("AutoFormat", {})
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = { "*.rs", "*.lua", "*.go", "*.ts", "*.cpp", "*.h, *.ts, *.js, *.html, *.css" },
        group = "AutoFormat",
        callback = function()
            vim.lsp.buf.format()
        end,
    }
)

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- vim.lsp.config.rust_analyzer = {
--     settings = {
--         ["rust-analyzer"] = {
--             check = {
--                 command = "clippy",
--                 extraArgs = { "--", "-W", "clippy::all" },
--             },
--         },
--     },
-- }

--- if you want to know more about lsp-zero and mason.nvim
--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { "gopls", "clangd", "pylsp", "lua_ls", "rust_analyzer", "html" },
    automatic_enable = {
        exclude = {
            "ltex_plus",
            "ltex",
        }
    }
})

local function dummy_commands(names)
    local t = {}
    for _, name in ipairs(names) do
        t["\\" .. name] = "dummy"
    end
    return t
end

vim.lsp.config.ltex_plus = {
    on_attach = function(client, bufnr)
        require("ltex_extra").setup {
            load_langs = { "en-US", "en-GB", "sv", "de" },
            path = vim.fn.expand('~') .. '/.local/share/ltex',
        }
    end,
    settings = {
        ltex = {
            disabledRules = {
                ['en-US'] = { 'PROFANITY' },
                ['en-GB'] = { 'PROFANITY' },
                ['sv'] = { 'PROFANITY' },
                ['de'] = { 'PROFANITY' },
            },
            latex = {
                ignoredEnvironments = {
                    "figure",
                    "pcvstack",
                    "procedure",
                    "pcb",
                    "pcheme",
                },
                commands = vim.tbl_extend("force",
                    dummy_commands({
                        -- algorithms
                        "setup", "keygen", "kg", "sign", "eval", "verify", "ver",
                        -- schemes/notions
                        "con", "whuf", "MKHSprimitive", "mkhs", "mklhs",
                        "HUFCMA", "wHUFCMA", "EXP", "coCDH", "dlog",
                        -- parties
                        "adv", "reduction", "challenger", "reductioncoCDH",
                        -- text abbreviations
                        "etal", "eg", "ie", "myparse",
                        "Aa", "Cc",
                    }), {
                        -- cryptocode commands with arguments
                        ["\\procedure[]{}{}"] = "ignore",
                        ["\\pcalgostyle{}"] = "ignore",
                    }
                ),
            },
        },
    },
}
vim.lsp.enable('ltex_plus')

-- Show diagnostic of current line with <leader> + D + I
vim.keymap.set(
    "n",
    "<leader>di",
    function() vim.diagnostic.open_float() end,
    { desc = "LSP: Show Line Diagnostics" }
)

-- Show references of where used
vim.keymap.set(
    "n",
    "<leader>gr",
    function() vim.diagnostic.open_float() end,
    { desc = "LSP: Show Line Diagnostics" }
)

-- Jump to next diagnostic with g + [ or g + ]
vim.keymap.set("n", "g]", vim.diagnostic.goto_next)
vim.keymap.set("n", "g[", vim.diagnostic.goto_prev)

-- ### Custom cmp configs: ###
local cmp = require('cmp')
local ls = require('luasnip')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    mapping = {
        -- Tab: if completion menu is visible, confirm selection; else, behave like supertab
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({ select = true })
            elseif ls.expand_or_jumpable() then
                ls.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),

        -- Shift-Tab: jump backward in snippet
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if ls.jumpable(-1) then
                ls.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        -- more sources
    },
    experimental = {
        ghost_text = true,
    },
})

-- Lua
vim.lsp.config.lua_ls = {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}
vim.lsp.enable('lua_ls')
