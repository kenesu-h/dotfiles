vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if #vim.fn.argv() == 0 then
      return
    end

    local arg = vim.fn.argv(0)

    if vim.fn.isdirectory(arg) == 0 then
      vim.cmd("edit " .. arg)
      return
    end

    vim.cmd("cd " .. arg)
    vim.cmd("enew")
  end,
})
