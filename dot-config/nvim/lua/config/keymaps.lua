-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

function RunCommand(command, description)
  -- Run the command and capture the output
  local handle = io.popen(command .. " 2>&1") -- Redirect stderr to stdout
  local result = handle:read("*a")
  local success = handle:close()

  -- Check the result of the make command
  if success then
    vim.notify(description .. " succeeded", "info")
  else
    vim.notify(description .. " failed:\n" .. result, "error")
  end
end

-- Map <leader>sp to the Telescope notify command
-- vim.keymap.set("n", "<leader>sp", "<cmd>Telescope notify<cr>", { desc = "Print notifications" })
vim.keymap.set("n", "<leader>mm", "<cmd>make<cr>", { desc = "make all" })

vim.keymap.set("n", "<leader>mb", function()
  RunCommand("bear --force-wrapper -- make -B", "Bear")
end, { desc = "bear" })

vim.keymap.set("n", "o", "<cmd>normal! o<cr>")
vim.keymap.set("n", "O", "<cmd>normal! O<cr>")
