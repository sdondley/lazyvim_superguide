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
        
        -- Now we will add a new plugin to our setup called which-key.nvim
        -- This plugin helps us remember key maps
        -- See https://github.com/folke/which-key.nvim for details
		{
			"folke/which-key.nvim", -- The last part of the GitHub repo
			lazy = false,           -- plugin loads right away
		  	init = function()       -- the init function is always run
				vim.opt.timeout = true
				vim.opt.timeoutlen = 200
		  	end,
			opts = {}               -- additional plugin opts can go here
		},

        -- end which_key --
    }, 
    {}  -- our lazy.nvim options will go here
)

-- end setup --
