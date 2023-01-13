-- NOTE: Need to do a first check for install instead of every time
-- require'install-rg'.install()
-- if is_installed == false then return false end

local rg = function (opts)
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

Rg = {
  rg = rg
}
