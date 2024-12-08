return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- zls = {
        --   settings = {
        --     zls = {
        --       enable_snippets = true,
        --     },
        --   },
        -- },
        perlnavigator = {},
        asm_lsp = {
          cmd = { "/home/tintin/.local/share/cargo/bin/asm-lsp" },
          filetypes = { "asm", "s", "S" },
        },
      },
    },
  },
}
