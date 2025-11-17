return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = false, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = false, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = false })
        end,
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = false })
        end,
        desc = "Buffer Explorer",
      },
    },
    opts = {
      commands = {
        diff_files = function(state)
          local node = state.tree:get_node()
          local log = require("neo-tree.log")
          state.clipboard = state.clipboard or {}
          if diff_Node and diff_Node ~= tostring(node.id) then
            local current_Diff = node.id
            require("neo-tree.utils").open_file(state, diff_Node, open)
            vim.cmd("vert diffs " .. current_Diff)
            log.info("Diffing " .. diff_Name .. " against " .. node.name)
            diff_Node = nil
            current_Diff = nil
            state.clipboard = {}
            require("neo-tree.ui.renderer").redraw(state)
          else
            local existing = state.clipboard[node.id]
            if existing and existing.action == "diff" then
              state.clipboard[node.id] = nil
              diff_Node = nil
              require("neo-tree.ui.renderer").redraw(state)
            else
              state.clipboard[node.id] = { action = "diff", node = node }
              diff_Name = state.clipboard[node.id].node.name
              diff_Node = tostring(state.clipboard[node.id].node.id)
              log.info("Diff source file " .. diff_Name)
              require("neo-tree.ui.renderer").redraw(state)
            end
          end
        end,
      },
      window = {
        mappings = {
          ["e"] = {
            function()
              vim.api.nvim_exec("Neotree focus filesystem left", true)
            end,
            desc = "Filesystem view",
          },
          ["b"] = {
            function()
              vim.api.nvim_exec("Neotree focus buffers left", true)
            end,
            desc = "Buffers view",
          },
          ["g"] = {
            function()
              vim.api.nvim_exec("Neotree focus git_status left", true)
            end,
            desc = "Git view",
          },
          ["D"] = "diff_files",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "→", -- default: ""
          expander_expanded = "↓", -- default: ""
          expander_highlight = "NeoTreeExpander",
        },
      },
      -- event_handlers = {
      --   {
      --     event = "neo_tree_buffer_enter",
      --     handler = function()
      --       vim.api.nvim_set_hl(0, "Cursor", { blend = 100 })
      --     end,
      --   },
      --   {
      --     event = "neo_tree_buffer_leave",
      --     handler = function()
      --       vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
      --     end,
      --   },
      -- },
    },
  },
}
