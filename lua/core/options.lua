local o = vim.opt

o.number = true
o.relativenumber = true
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.wrap = false
o.termguicolors = true
o.cursorline = true
o.scrolloff = 20
o.signcolumn = "yes"
o.clipboard = "unnamedplus"

if vim.fn.exists("&winborder") == 1 then
  o.winborder = "rounded"
end
