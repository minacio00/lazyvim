return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts = opts or {}
      opts.options = opts.options or {}
      -- Current option
      opts.options.always_show_bufferline = true
      return opts
    end,
  },
  {
    { "tiagovla/scope.nvim", event = "VeryLazy", config = true },
  },
}
