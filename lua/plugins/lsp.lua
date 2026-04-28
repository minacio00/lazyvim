return {
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
