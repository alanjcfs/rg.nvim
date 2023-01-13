InstallRg = require('install-rg')

Rg = function (opts)
  local is_installed = InstallRg()
  if is_installed == false then return false end

  if opts.fargs[2] == nil then
    opts.fargs[2] = './'
  end

  if vim.g.rgprg == nil then
    vim.g.rgprg = "rg --vimgrep --smartcase"
  end

  local str_query = vim.fn.shellescape(opts.fargs[1])
  local dir = vim.fn.shellescape(opts.fargs[2])
  local cmd = string.format("cgetexpr system('%s %s %s')", vim.g.rgprg, str_query, dir)
  vim.cmd(cmd)
  vim.cmd("copen")

  if vim.o.buftype == "quickfix" then
    vim.cmd("nnoremap gq :cclose<CR>")
  end
end

vim.api.nvim_create_user_command('Rg', Rg, { nargs = '*' })
