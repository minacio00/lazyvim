return {
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {
      filewatching = "off",
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
  },
}
