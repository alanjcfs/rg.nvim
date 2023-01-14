-- NOT: Need to do a first check for install instead of every time
local install = require'rg/install-rg'

local setup = function ()
  local Rg = function (opts)
    if vim.g.rgprg == nil then
      vim.g.rgprg = "rg --vimgrep --smartcase"
    end

    local interpolated_string = string.format("cgetexpr system('%s')", opts.args)
    local escaped_string = vim.fn.shellescape(interpolated_string)

    print(escaped_string)
    vim.cmd(cmd)
    vim.cmd("copen")

    if vim.o.buftype == "quickfix" then
      vim.cmd("nnoremap gq :cclose<CR>")
    end
  end


  vim.api.nvim_create_user_command('Rg', Rg, { nargs = '*' })
end

return {
  setup = setup,
  install = install
}
