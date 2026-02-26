return
{
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  opts = {
      vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>"),
      keymaps = {
        ["l"] = "actions.select",
        ["h"] = "actions.parent",
        ["q"] = { "actions.close", mode = "n" },
      },
      view_options = {
        show_hidden = true,
    --     is_hidden_file = function(name, _)
    --       if name:sub(1,1) == '.' then
    --         return true
    --       end
    --
    --       if name == "venv" or name == ".venv" then
    --         return true
    --       end
    --       return false
    --     end
    },
  },
}
