vim.cmd([[
  augroup FileTypeOverrides
    autocmd!
    autocmd TermOpen * setlocal nospell
  augroup END
]])

-- Define a function to save the file
function SaveFile()
  vim.cmd(':w')
end

-- Automatically save the file when exiting insert mode
vim.cmd('augroup autosave')
vim.cmd('autocmd!')
vim.cmd('autocmd InsertLeave * lua SaveFile()')
vim.cmd('augroup END')

