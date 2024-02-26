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
            lazy = false, -- override the default lazy load setting
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
			lazy = false,  -- override the default lazy load setting
		  	init = function()       
				vim.opt.timeout = true
				vim.opt.timeoutlen = 200
		  	end,
			opts = {}               
		},

        -- custom_plugin --

        -- The "my_plugin" plugin will no longer load at startup because it is lazily loaded
        {
            dir = "~/projects/my_plugin", 
            config = function()
                require("my_plugin")
            end
        },

        -- end custom_plugin --

        -- end which_key --
    }, 
    {
        -- global lazy --
        
        -- Our first setting in the opts table overrides the default setting for lazy loading.
        -- We change it from false to true.
        -- Now all plugins will be lazy loaded by default.
        -- Now, for each plugin, we must manually set the conditions for them to load in the plugin spec.
        default = { lazy = true }
        -- end global lazy --
    }
)

-- end setup --
