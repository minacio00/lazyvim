-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
--
-- ~/.config/nvim/lua/config/autocmds.lua

-- Helper to create augroups if you need them later
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Open a terminal in a new tab on startup when no files are passed
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  once = true,
  callback = function()
    -- Only when launching without files: don't touch `nvim somefile`
    if vim.fn.argc(-1) > 0 then
      return
    end
    -- Avoid headless/embedded sessions
    if #vim.api.nvim_list_uis() == 0 or vim.g.started_by_firenvim then
      return
    end

    -- Create Tab 2 with a terminal and enter insert mode
    vim.cmd("tabnew | terminal")
    vim.cmd("startinsert")
  end,
})
