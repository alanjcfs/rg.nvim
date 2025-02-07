local setup = function ()
  if vim.g.rgprg == nil then
    vim.g.rgprg = "rg --vimgrep --smart-case --column"
  end

  if vim.g.rg_command_name == nil then
    vim.g.rg_command_name = "Ripgrep"
  else
    -- Capitalize the command.
    vim.g.rg_command_name = vim.g.rg_command_name:gsub("^%l", string.upper)
  end

  function Rg(args)
    local interpolated_string = string.format("cgetexpr system(g:rgprg .. ' ' .. shellescape(expand('%s')))", args)

    -- print(interpolated_string)
    vim.cmd(interpolated_string)
    vim.cmd("copen")

    if vim.o.buftype == "quickfix" then
      vim.cmd("nnoremap <buffer> gq :cclose<CR>")
      vim.cmd.augroup("rgnvim")
      -- vim.cmd.autocmd("autocmd BufReadPost quickfix nnoremap t normal :setl switchbuf=newtab<cr><cr>")
      -- vim.keymap.set("n", "o", ":exe 'normal :setl switchbuf=useopen'<cr><cr>")
      -- vim.keymap.set("n", "<CR>", "@:exe ':set switchbuf=useopen'<CR><CR>")
      -- vim.keymap.set("n", "o", "@:exe ':set switchbuf=useopen'<CR><CR>")
      -- vim.keymap.set("n", "O", "@:exe ':set switchbuf=useopen'<CR>':cclose'<CR><CR>")
      -- vim.keymap.set("n", "go", "@:exe ':set switchbuf=useopen'<CR>':normal <c-w>p'<CR>")
      -- vim.keymap.set("n", "t", "@:exe ':setl switchbuf=newtab'<CR><CR>")
      -- vim.keymap.set("n", "T", "@:exe ':set switchbuf=split'<CR>':normal :tp'<CR><CR>")
      -- vim.keymap.set("n", "h", "@:exe ':setl switchbuf=split'<CR><CR>")
      -- vim.keymap.set("n", "H", "@:exe ':set switchbuf=split'<CR>':normal <C-W>p'<CR>")
      -- vim.keymap.set("n", "v", "@:exe ':setl switchbuf=vsplit'<CR><CR>")
    end
  end


  -- vim.api.nvim_create_user_command('Rg', Rg, {})
  vim.api.nvim_exec2("command! -nargs=* " .. vim.g.rg_command_name .. " call luaeval(\'Rg(_A)\' , '<args>')", { output = true })
end

return {
  setup = setup,
}
