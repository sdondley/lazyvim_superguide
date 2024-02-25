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

-- Now we'll load in a simple lua file containing some custom settings for the neovim editor.
-- This is just the standard way of loading a file in Lua.
-- Note the "." is a substitute for the "/" in the path.
require("custom.my_settings");

-- end custom --

-- setup --

require("lazy").setup(
    {
        -- theme --
        -- Add a theme to make things a little prettier
        -- These setting ensure the theme will be loaded early in the startup process
        -- Settings are from the lazy.nvim README file with additional "opts" settings
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
    }, 
    {}  -- our lazy.nvim options will go here
)


-- end setup --
