local function bootstrap_pckr()
    local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

    if not (vim.uv or vim.loop).fs_stat(pckr_path) then
        vim.fn.system({
            'git',
            'clone',
            "--filter=blob:none",
            'https://github.com/lewis6991/pckr.nvim',
            pckr_path
        })
    end

    vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add {
    -- Packer can manage itself
    {
        'wbthomason/packer.nvim'
    },

    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    },

    {
        "neanias/everforest-nvim",
        config = function()
            require("everforest").setup({
                background = "medium",
                italics = true,
            })
        end,
    },


    {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    },

    {
        'theprimeagen/harpoon'
    },

    {
        'mbbill/undotree'
    },

    {
        'tpope/vim-fugitive'
    },

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    },
    -- LSP Zero
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            { 'neovim/nvim-lspconfig' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    },
    "tamago324/nlsp-settings.nvim", -- language server settings defined in json for

    -- DAP
    {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
        "jay-babu/mason-nvim-dap.nvim",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },

    {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = {
                "markdown" }
        end,
        ft = { "markdown" },
    },

    "nvim-lua/plenary.nvim",

    { 'jbyuki/nabla.nvim' },

    { 'nfrid/markdown-togglecheck' },
    { 'nfrid/treesitter-utils' },

    --  'mfussenegger/nvim-jdtls';

    {
        "stevearc/oil.nvim",
    },

    'echasnovski/mini.icons',
    'nvim-tree/nvim-web-devicons',

    "3rd/image.nvim",

    {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    },

    "RRethy/base16-nvim",

    "lewis6991/gitsigns.nvim",

    "FabijanZulj/blame.nvim",

    "aserowy/tmux.nvim",

    {
        "dustinblackman/oatmeal.nvim",
    },

    'norcalli/nvim-colorizer.lua',

    {
        "folke/persistence.nvim",
        event = "BufReadPre" -- this will only start session saving when an actual file was opened
    },

}
