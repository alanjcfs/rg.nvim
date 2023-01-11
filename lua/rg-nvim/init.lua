Ack = function (opts)
  if opts.fargs[2] == nil then
    opts.fargs[2] = './'
  end

  local str_query = vim.fn.shellescape(opts.fargs[1])
  local dir = vim.fn.shellescape(opts.fargs[2])
  local cmd = string.format("cgetexpr system('%s %s %s')", vim.g.ackprg, str_query, dir)
  vim.cmd(cmd)
  vim.cmd("copen")

  if vim.o.buftype == "quickfix" then
    vim.cmd("nnoremap gq :cclose<CR>")
  end
end

vim.api.nvim_create_user_command('Ack', Ack, { nargs = '*' })
