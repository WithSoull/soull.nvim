-- remove noisy notify messages
local orig = vim.notify
vim.notify = function(msg, level, opts)
  if type(msg) == "string"
     and msg:match("require%('lspconfig'%)")  -- источник
     and msg:match("deprecated")              -- характер
  then
    return -- глушим именно это предупреждение
  end
  return orig(msg, level, opts)
end

-- Bootstrap lazy
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

-- This has to be set before initializing lazy
vim.g.mapleader = " "

-- Initialize lazy with dynamic loading of anything in the plugins directory
require("lazy").setup("plugins", {
   change_detection = {
    enabled = true, -- automatically check for config file changes and reload the ui
    notify = false, -- turn off notifications whenever plugin changes are made
  },
})
--

-- These modules are not loaded by lazy
require("core.options")
require("core.keymaps")
pcall(require, "private")
