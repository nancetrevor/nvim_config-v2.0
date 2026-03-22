vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.keymaps")
require("config.lazy")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    for _, a in ipairs(vim.v.argv) do
      if a:match("^%+.+") then
        return
      end
    end
    if vim.fn.argc() == 0 then
      vim.schedule(function()
        require("oil").open(vim.fn.getcwd(), {
          preview = {
            vertical = true,
            split = "botright",
          },
        })
      end)
    end
  end,
})
