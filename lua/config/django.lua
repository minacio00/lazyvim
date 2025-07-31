-- ~/.config/nvim/lua/config/django.lua
-- Django-specific autocmds and configurations

local M = {}

-- Function to detect Django project
local function is_django_project()
  local files = { "manage.py", "django_project", "settings.py" }
  for _, file in ipairs(files) do
    if vim.fn.filereadable(file) == 1 or vim.fn.glob("**/" .. file) ~= "" then
      return true
    end
  end
  return false
end

-- Function to set up Django environment
local function setup_django_env()
  -- Set Django environment variables
  vim.env.DJANGO_SETTINGS_MODULE = vim.env.DJANGO_SETTINGS_MODULE

  -- Add Django-specific key mappings
  local opts = { noremap = true, silent = true }

  -- Django management commands
  vim.keymap.set("n", "<leader>dm", ":term python manage.py<CR>", opts)
  vim.keymap.set("n", "<leader>dr", ":term python manage.py runserver<CR>", opts)
  vim.keymap.set("n", "<leader>ds", ":term python manage.py shell<CR>", opts)
  vim.keymap.set("n", "<leader>dt", ":term python manage.py test<CR>", opts)
  vim.keymap.set("n", "<leader>dM", ":term python manage.py makemigrations<CR>", opts)
  vim.keymap.set("n", "<leader>dg", ":term python manage.py migrate<CR>", opts)

  -- Quick file navigation
  vim.keymap.set("n", "<leader>du", ":e urls.py<CR>", opts)
  vim.keymap.set("n", "<leader>dv", ":e views.py<CR>", opts)
  vim.keymap.set("n", "<leader>do", ":e models.py<CR>", opts)
  vim.keymap.set("n", "<leader>df", ":e forms.py<CR>", opts)
  vim.keymap.set("n", "<leader>da", ":e admin.py<CR>", opts)
  vim.keymap.set("n", "<leader>dS", ":e settings.py<CR>", opts)
end

-- Set up Django autocommands
function M.setup()
  local group = vim.api.nvim_create_augroup("DjangoConfig", { clear = true })

  -- Auto-detect Django projects and set up environment
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = group,
    pattern = "*.py",
    callback = function()
      if is_django_project() then
        setup_django_env()
      end
    end,
  })

  -- Set up Django template files
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = group,
    pattern = { "*.html", "*.htm" },
    callback = function()
      if is_django_project() then
        vim.bo.filetype = "htmldjango"
      end
    end,
  })

  -- Set up Django settings files
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = group,
    pattern = { "settings.py", "settings/*.py" },
    callback = function()
      vim.bo.filetype = "python"
      -- Add Django-specific settings
      vim.opt_local.colorcolumn = "120"
    end,
  })

  -- Set up Django models with proper formatting
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = group,
    pattern = "models.py",
    callback = function()
      -- Add model-specific snippets or configurations
    end,
  })
end

return M
