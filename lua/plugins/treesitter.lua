vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "lua", "go", "javascript", "html", "rust" },
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
