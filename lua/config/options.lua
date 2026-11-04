-- line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- indentation and tab space
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.expandtab = true

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- appearance
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"

-- indentation
vim.opt.smartindent = true

-- wrap and backup
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.cache/nvim/undodir")

-- cursorline
vim.opt.cursorline = true

-- 80th or 120th column
vim.opt.colorcolumn = "120"

-- clipboard
vim.opt.clipboard:append("unnamedplus")

-- backspace
vim.opt.backspace = "indent,eol,start"

-- split windows
vim.opt.splitbelow = true
vim.opt.splitright = true

-- dw/diw/ciw works on full word
vim.opt.iskeyword:append("-")

-- keep cursor at least 8 rows from top/bottom
vim.opt.scrolloff = 8

-- incremental search
vim.opt.incsearch = true
