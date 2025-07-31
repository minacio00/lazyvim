return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = false,
        ts_ls = false,
        omnisharp = {
          cmd = { "omnisharp" },
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
        },
      },
    },
  },
  {
    "nvim-lspconfig",
    keys = {
      -- Explicitly map gd to definition instead of declaration for all LSP clients
      {
        "gd",
        function()
          vim.lsp.buf.definition()
        end,
        desc = "Go to definition",
      },
    },
  },
}
