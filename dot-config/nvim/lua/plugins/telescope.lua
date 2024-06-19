-- change some telescope options and a keymap to browse plugin files

local Path = require("plenary.path")

local function extract_makefile_targets()
  local targets = {}
  local makefile_path = Path:new("Makefile")

  for line in makefile_path:iter() do
    local target = line:match("^([%w-_]+):")
    if target then
      table.insert(targets, target)
    end
  end

  return targets
end

local function makefile_targets_picker(opts)
  local pickers = require("telescope.pickers")
  local previewers = require("telescope.previewers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  opts = opts or {}
  local targets = extract_makefile_targets()

  pickers
    .new(opts, {
      prompt_title = "Makefile Targets",
      finder = finders.new_table({
        results = targets,
        -- entry_maker = function(entry)
        --   return {
        --     value = entry,
        --     display = entry,
        --     ordinal = entry,
        --   }
        -- end,
      }),
      sorter = conf.generic_sorter(opts),
      previewer = previewers.new_termopen_previewer({
        get_command = function(entry, status)
          return { "make", "-n", entry[1] }
        end,
      }),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          vim.cmd("make " .. selection.value)
        end)
        return true
      end,
    })
    :find()
end

return {
  {
    "chip/telescope-software-licenses.nvim",
    depends = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("software-licenses")
    end,
    keys = {
      {
        "<leader>fl",
        "<cmd>Telescope software-licenses find<cr>",
        desc = "Software Licenses",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fm",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      {
        "<leader>mt",
        makefile_targets_picker,
        desc = "make target",
      },
    },
    -- change some options
    opts = {
      -- defaults = {
      --   layout_strategy = "horizontal",
      --       layout_config = { prompt_position = "top" },
      --   sorting_strategy = "ascending",
      --   winblend = 0,
      -- },
    },
  },
}
