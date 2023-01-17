-- NOT: Need to do a first check for install instead of every time
local install = require'rg/install-rg'

local setup = function ()
  if vim.g.rgprg == nil then
    vim.g.rgprg = "rg --vimgrep --smart-case"
  end

  function Rg(args)
    local interpolated_string = string.format("cgetexpr system('%s %s')", vim.g.rgprg, args)

    vim.cmd(interpolated_string)
    vim.cmd("copen")

    if vim.o.buftype == "quickfix" then
      vim.cmd("nnoremap gq :cclose<CR>")
    end
  end


  -- vim.api.nvim_create_user_command('Rg', Rg, {})
  vim.api.nvim_exec("command! -nargs=* Rg call luaeval('Rg(_A)', expand('<args>'))", true)
end

return {
  setup = setup,
  install = install
}
