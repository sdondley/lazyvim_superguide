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

        -- Add a custom plugin to the configuration with this new plugin spec entry
        {
            -- Tell lazy where to find our plugin on our local machine:
            dir = "~/projects/my_plugin", 

            -- Lazy nvim calls the config function below when loading the plugin.
            -- Here we require our plugin's init.lua file to execute the code in the file.
            -- Neovim searches the plugin's directories for the "init.lua" file automatically.
            -- See ":h require" for more information on how Neovim loads init files.
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
