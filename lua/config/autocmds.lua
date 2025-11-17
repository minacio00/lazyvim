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
-- Add this to your existing autocmds.lua file

require("config.django").setup()

-- Additional Django-specific autocommands
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

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

-- Django Python file settings
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("django_python"),
  pattern = "python",
  callback = function()
    -- Check if we're in a Django project
    local django_files = vim.fn.glob("manage.py") ~= "" or vim.fn.glob("**/manage.py") ~= ""
    if django_files then
      -- Set Django-specific options
      vim.opt_local.colorcolumn = "88"
      vim.opt_local.textwidth = 88

      -- Set up Django imports completion
      vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")

      -- Django-specific abbreviations
      vim.cmd([[
        iabbrev <buffer> pdb import pdb; pdb.set_trace()
        iabbrev <buffer> ipdb import ipdb; ipdb.set_trace()
        iabbrev <buffer> djmodel from django.db import models
        iabbrev <buffer> djview from django.views import View
        iabbrev <buffer> djgeneric from django.views.generic import
        iabbrev <buffer> djurls from django.urls import path, include
        iabbrev <buffer> djhttp from django.http import HttpResponse, HttpResponseRedirect
        iabbrev <buffer> djshortcuts from django.shortcuts import render, redirect, get_object_or_404
        iabbrev <buffer> djforms from django import forms
        iabbrev <buffer> djadmin from django.contrib import admin
        iabbrev <buffer> djuser from django.contrib.auth.models import User
        iabbrev <buffer> djauth from django.contrib.auth import authenticate, login, logout
        iabbrev <buffer> djsettings from django.conf import settings
      ]])
    end
  end,
})

-- Django HTML template settings
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("django_html"),
  pattern = "htmldjango",
  callback = function()
    vim.opt_local.colorcolumn = "120"
    vim.opt_local.textwidth = 120

    -- Django template abbreviations
    vim.cmd([[
      iabbrev <buffer> dj{{ {{ }}<Left><Left><Left>
      iabbrev <buffer> dj{%  {% %}<Left><Left><Left>
      iabbrev <buffer> djfor {% for %}<Left><Left><Left>
      iabbrev <buffer> djif {% if %}<Left><Left><Left>
      iabbrev <buffer> djurl {% url '' %}<Left><Left><Left><Left>
      iabbrev <buffer> djstatic {% load static %}<CR>{% static '' %}<Left><Left><Left>
      iabbrev <buffer> djblock {% block %}<CR>{% endblock %}<Up><Left><Left><Left>
      iabbrev <buffer> djextends {% extends '' %}<Left><Left><Left>
      iabbrev <buffer> djinclude {% include '' %}<Left><Left><Left>
      iabbrev <buffer> djcomment {% comment %}<CR>{% endcomment %}<Up>
      iabbrev <buffer> djcsrf {% csrf_token %}
    ]])
  end,
})
