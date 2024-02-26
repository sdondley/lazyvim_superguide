-- lazy_init --

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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

-- end lazy_init --

-- custom --

require("my_settings");

-- end custom --

-- setup --

require("lazy").setup(
    {
        -- theme --
        {
            "folke/tokyonight.nvim",
            lazy = false, 
            priority = 1000,
            init = function()
                vim.cmd([[colorscheme tokyonight]])
            end,
            opts = { style = "moon", transparent = true }
        },
        -- end theme --

        -- which_key --
		{
			"folke/which-key.nvim", 
			lazy = false,
		  	init = function()       
				vim.opt.timeout = true
				vim.opt.timeoutlen = 200
		  	end,
			opts = {}               
		},
        -- end which_key --

        -- custom_plugin --
        {
            dir = "~/projects/my_plugin", 
            -- filetype --
            ft = { "text" }, -- The plugin will now only load when we open a text file
            -- end filetyp --
            config = function()
                require("my_plugin")
            end
        },
        -- end custom_plugin --

    }, 
    {
        -- global lazy --
        default = { lazy = true }
        -- end global lazy --
    }
)

-- end setup --
