-- return {
--   {
--     "seblyng/roslyn.nvim",
--     ft = { "cs", "razor", "cshtml" },
--     opts = {
--       filewatching = "auto",
--       settings = {
--         ["csharp|background_analysis"] = {
--           dotnet_compiler_diagnostics_scope = "fullSolution",
--           dotnet_analyzer_diagnostics_scope = "fullSolution",
--         },
--       },
--     },
--   },
-- }
--

vim.lsp.config("roslyn", {
  settings = {
    ["csharp|background_analysis"] = {
      dotnet_compiler_diagnostics_scope = "fullSolution",
      dotnet_analyzer_diagnostics_scope = "openFiles",
    },
  },
})

return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor", "cshtml" },
    opts = {
      filewatching = "auto",
    },
  },
}
