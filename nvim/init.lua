-- lazy_init --

-- assign 'lazypath' to the directory for downloading the lazy.nvim module
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

-- add the lazypath directory to the front of the 'runtime path' option
-- this ensures neovim will look in this directory first for plugins and other files at runtime
vim.opt.rtp:prepend(lazypath)

-- end lazy_init --
