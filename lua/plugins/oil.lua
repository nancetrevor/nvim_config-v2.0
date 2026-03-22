return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },

  keys = {
    {
      "<leader>e",
      function()
        require("oil").open(nil, {
          preview = {
            vertical = true,
            split = "botright",
          },
        })
      end,
      desc = "Open Oil with preview",
    },
  },

  opts = {
    keymaps = {
      ["l"] = "actions.select",
      ["h"] = "actions.parent",
      ["q"] = { "actions.close", mode = "n" },
      ["<C-p>"] = "actions.preview",
    },

    view_options = {
      show_hidden = true,
    },

    lsp_file_methods = {
      enabled = false,
    },

    preview_win = {
      update_on_cursor_moved = true,
      preview_method = "fast_scratch",
    },
  },
}
