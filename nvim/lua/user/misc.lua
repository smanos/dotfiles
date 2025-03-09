vim.cmd([[
    augroup FileTypeOverrides
    autocmd!
    autocmd TermOpen * setlocal nospell
   augroup END
]])

-- Define a function to save the file
function SaveFile()
	vim.cmd(":w!")
end

-- Automatically save the file when exiting insert mode
vim.cmd("augroup autosave")
vim.cmd("autocmd!")
vim.cmd("autocmd InsertLeave * lua SaveFile()")
vim.cmd("augroup END")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
