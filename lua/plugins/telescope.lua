return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function() return vim.fn.executable("make") == 1 end,
      },
    },

    -- ✅ Put ignore patterns under `defaults`
    opts = function()
      -- Make live_grep also ignore venvs by tweaking ripgrep args
      local tcfg = require("telescope.config")
      local vimgrep_arguments =  vim.deepcopy(tcfg.values.vimgrep_arguments)
      -- Exclude common venv dirs from ripgrep-based pickers (live_grep, grep_string)
      for _, glob in ipairs({ "!**/venv/**", "!**/.venv/**", "!**/env/**", "!**/__pycache__/**" }) do
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, glob)
      end

      return {
        defaults = {
          file_ignore_patterns = { "venv", "%.venv", "__pycache__", ".git", "git" },
          vimgrep_arguments = vimgrep_arguments,
        },

        -- Optional: finder tweaks
        pickers = {
          find_files = {
            hidden = true,  -- still see dotfiles if not ignored
            follow = true,  -- follow symlinks
            -- If you prefer fd-specific excludes, uncomment:
            -- find_command = {
            --   "fd", "--type", "f", "--hidden", "--follow",
            --   "--exclude", "venv", "--exclude", ".venv",
            --   "--exclude", "env", "--exclude", "__pycache__",
            -- },
          },
        },
      }
    end,

    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      -- Load fzf if available
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
