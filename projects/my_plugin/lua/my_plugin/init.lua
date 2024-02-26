-- We have converted this module to use a more conventional Neovim plugin structure
-- by adding our functions to lua table "M" and returning the table at the end of the file.
local M = {}

-- The lazy plugin manager calls this function to setup the plugin
-- We add this function to the "M" table so that the lazy plugin manager can call it
-- The setup function receives the opts argument which we use to turn line number on or off
function M.setup(opts)
    vim.opt.number = opts.line_numbers 
end

return M
