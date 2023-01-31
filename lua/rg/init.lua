local setup = function ()
  if vim.g.rgprg == nil then
    vim.g.rgprg = "rg --vimgrep --smart-case"
  end

  if vim.g.rg_command_name == nil then
    vim.g.rg_command_name = "Ripgrep"
  else
    -- Capitalize the command.
    vim.g.rg_command_name = vim.g.rg_command_name:gsub("^%l", string.upper)
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
  vim.api.nvim_exec("command! -nargs=* " .. vim.g.rg_command_name .. " call luaeval('Rg(_A)', expand('<args>'))", true)
end

return {
  setup = setup,
}
