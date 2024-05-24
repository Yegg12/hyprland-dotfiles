require "lsp";
require "coqnvim";

local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	{"neovim/nvim-lspconfig"},					
	{"ms-jpq/coq_nvim"},
	{"ms-jpq/coq.artifacts", branch = "artifacts"},
	{"elkowar/yuck.vim"},
	{"folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {}},
	{"nvim-lualine/lualine.nvim"},
	{"mfussenegger/nvim-dap"},
	{"rcarriga/nvim-dap-ui"},
	{"kdheepak/lazygit.nvim", dependencies = {"nvim-lua/plenary.nvim"}},
    {"nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim"}}
	})

require "dapnvim";
require "telescope";

local lspconfig = require('lspconfig')
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {}
lspconfig.clangd.setup {}
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
})

require('tokyonight').setup ({
	style = "night",
	transparent = false,

	on_colors = function(colors)
        colors.comment = colors.green
    end,

    on_highlights = function(hl, c)
        local background = "#1a1b26"
        hl.TelescopeNormal = {
            bg = background,
        }
        hl.TelescopeBorder = {
            bg = background,
        }
        hl.TelescopePromptNormal = {
            bg = background,
        }
        hl.TelescopePromptBorder = {
            bg = background,
        }
        hl.TelescopePromptTitle = {
            bg = background,
        }
        hl.TelescopePreviewTitle = {
            bg = background,
        }
        hl.TelescopeResultsTitle = {
            bg = background,
        }
    end,
})

require('lualine').setup {
	options = {
		theme = 'tokyonight'
	}
}


vim.cmd[[colorscheme tokyonight]]
vim.cmd[[
	set expandtab
	set tabstop=4
	set shiftwidth=4
]]
