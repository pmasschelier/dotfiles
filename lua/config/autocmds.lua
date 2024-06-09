-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Function to run 'cargo run' interactively
local function run_cargo_interactive()
  vim.api.nvim_command("split")
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, buf)
  vim.api.nvim_command("term cargo run")
  vim.api.nvim_command("startinsert")
end

-- Function to set up the keymap
local function setup_rust_cargo_keymap()
  vim.keymap.set("n", "<leader>mr", function()
    run_cargo_interactive()
  end, { desc = "cargo run", noremap = true, silent = true })
end

-- Autocommand to set up the keymap for Rust files and Cargo.toml
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.rs", "Cargo.toml" },
  callback = setup_rust_cargo_keymap,
})
