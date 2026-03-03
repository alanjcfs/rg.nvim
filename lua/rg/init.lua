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

  local function Rg(opts)
    if opts.args == '' then
      vim.notify('Ripgrep: no search term provided', vim.log.levels.WARN)
      return
    end

    local pattern = opts.args
    local path_arg = ''

    -- If the last word is an existing directory, use it as the search path
    local last_word = opts.args:match('%S+$')
    if last_word then
      local expanded = vim.fn.expand(last_word)
      if vim.fn.isdirectory(expanded) == 1 then
        local prefix = opts.args:sub(1, #opts.args - #last_word):gsub('%s+$', '')
        if prefix ~= '' then
          pattern = prefix
          path_arg = ' ' .. vim.fn.shellescape(expanded)
        end
      end
    end

    local results = vim.fn.systemlist(vim.g.rgprg .. ' ' .. vim.fn.shellescape(pattern) .. path_arg)
    vim.fn.setqflist({}, 'r', { lines = results, efm = '%f:%l:%c:%m', title = 'rg: ' .. opts.args })
    vim.cmd('copen')
  end

  vim.api.nvim_create_user_command(vim.g.rg_command_name, Rg, { nargs = '*', complete = 'file' })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    group = vim.api.nvim_create_augroup('rgnvim', { clear = true }),
    callback = function()
      local map_opts = { buffer = true, noremap = true, silent = true }
      vim.keymap.set('n', 'o',    '<CR>',                               map_opts)
      vim.keymap.set('n', '<CR>', '<CR>',                               map_opts)
      vim.keymap.set('n', 'O',    '<CR>:cclose<CR>',                    map_opts)
      vim.keymap.set('n', 'go',   '<CR><C-W>p',                         map_opts)
      vim.keymap.set('n', 't',    '<C-W><CR><C-W>T',                    map_opts)
      vim.keymap.set('n', 'T',    '<C-W><CR><C-W>TgT<C-W>j',           map_opts)
      vim.keymap.set('n', 'h',    '<C-W><CR><C-W>K',                    map_opts)
      vim.keymap.set('n', 'H',    '<C-W><CR><C-W>K<C-W>b',              map_opts)
      vim.keymap.set('n', 'v',    '<C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t', map_opts)
      vim.keymap.set('n', 'gv',   '<C-W><CR><C-W>H<C-W>b<C-W>J<C-W>p', map_opts)
      vim.keymap.set('n', 'q',    ':cclose<CR>',                        map_opts)
      vim.keymap.set('n', 'gq',   ':cclose<CR>',                        map_opts)
    end
  })
end

return {
  setup = setup,
}
