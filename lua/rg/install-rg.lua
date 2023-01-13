local install = function()
  if vim.fn.executable('rg') == 1 then
    if vim.fn.executable('brew') == 0 then
      local answer, install, yeses = nil, false, {"y", "yes"}
      vim.ui.input({
          prompt = "You don't seem to have ripgrep executable. Install by homebrew? (y/N) "
        },
        function(input) answer = string.lower(input) end
        )
      for _,val in ipairs(yeses) do
        if val == answer then
          install = true
        end
      end

      if install == true then
        vim.cmd("exec ':!brew install ripgrep'")
      end

      return true
    else
      print("ripgrep is not install and package manager is not known")
    end

    -- Don't know how to deal with not having homebrew
    return false
  end

  -- ripgrep is install, so just move on
  return true
end

Rg = {
  install = install
}
