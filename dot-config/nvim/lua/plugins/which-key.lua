return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      local defaults = opts.defaults
      defaults["<leader>m"] = { name = "+make" }
      opts.defaults = defaults
    end,
  },
}
