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

        -- custom_plugin --

        {
            dir = "~/projects/my_plugin", 

            -- lazy_loading --
            lazy = true, -- We set lazy to a 'true'. Now lazy nvim will no longer load my_plugin plugin at startup.
            -- end lazy_loading --

            -- The config function is never run because the plugin is not loaded.
            config = function()
                require("my_plugin")
            end
        },

        -- end custom_plugin --

        -- end which_key --
    }, 
    {}  -- our lazy.nvim options will go here
)

-- end setup --
