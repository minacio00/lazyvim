return {
  -- Configure Pyright LSP for Django
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off", -- or "strict"
                diagnosticMode = "workspace",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
                stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs/stubs",
                extraPaths = {
                  vim.fn.getcwd(),
                  vim.fn.getcwd() .. "/venv/lib/python*/site-packages",
                },
              },
            },
          },
        },
      },
    },
  },

  -- Install python type stubs
  {
    "microsoft/python-type-stubs",
    build = function()
      -- This will be handled by pip install
    end,
  },

  -- Configure null-ls for mypy (optional - if you prefer mypy over pyright)
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(
        opts.sources,
        nls.builtins.diagnostics.mypy.with({
          extra_args = function()
            local virtual_env = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_DEFAULT_ENV")
            if virtual_env then
              return { "--python-executable", virtual_env .. "/bin/python" }
            end
            return {}
          end,
        })
      )
    end,
  },

  -- Configure conform for Python formatting
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "black", "isort" },
      },
    },
  },

  -- Add django-specific snippets and utilities
  {
    "L3MON4D3/LuaSnip",
    optional = true,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      -- Add Django-specific snippets
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })
    end,
  },

  -- File detection for Django
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "python", "html", "css", "javascript" })
    end,
  },
}
