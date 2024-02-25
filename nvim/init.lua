-- lazy_init --

-- Below is the lua code for setting up the lazy.nvim package manager plugin.
-- This code is taken straight from the GitHub README file for lazy.vim:
-- https://github.com/folke/lazy.nvim

-- Assign 'lazypath' to the directory for downloading the lazy.nvim module
-- vim.fn.stdpath("data") is "~/.local/share/nvim" by default
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- if lazypath does not already exist, git clone it into lazypath
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

-- Now add the lazypath directory to the front of the 'runtime path' option.
-- This ensures neovim will look in this directory first for plugins and other files at runtime.
-- See ":h rtp" in neovim for more details.
vim.opt.rtp:prepend(lazypath)

-- end lazy_init --

-- setup --

-- This line of code loads the lazy plugin's lua file and calls the setup method in it.
-- setup takes two tables as arguments:
   -- the plugin spec
   -- option configuration
-- Both of these are lua tables. We will leave them empty for now:
require("lazy").setup(
	{}, -- the plugin spec goes here
	{}  -- our options go here
)

-- end setup --
