-- Space is my leader.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- Quickly clear search highlighting.
vim.keymap.set("n", "<leader>k", ":nohlsearch<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Close all open buffers.
vim.keymap.set("n", "<leader>Q", ":bufdo bdelete<CR>")

-- Allow gf to open non-existent files.
vim.keymap.set("", "gf", ":edit <cfile><CR>")

-- Reselect visual selection after indenting.
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set("v", "y", "myy`y")
vim.keymap.set("v", "Y", "myY`y")

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Paste replace visual selection without copying it.
vim.keymap.set("v", "p", '"_dP')

-- Easy insertion of a trailing ; or , from insert mode.
vim.keymap.set("i", ";;", "<Esc>A;<Esc>")
vim.keymap.set("i", ",,", "<Esc>A,<Esc>")

-- Open the current file in the default program (on Mac this should just be just `open`).
vim.keymap.set("n", "<leader>x", ":!xdg-open %<cr><cr>")

-- Disable annoying command line thing.
vim.keymap.set("n", "q:", ":q<CR>")

-- Resize with arrows.
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Move around with control VIM keys
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
--
-- Show Calendar
vim.keymap.set("n", "<leader>3", ":Calendar -view=day -split=vertical -width=80<cr>")

-- Move text up and down
-- vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
-- vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
-- vim.keymap.set('n', '<A-j>', ':move .+1<CR>==')
-- vim.keymap.set('n', '<A-k>', ':move .-2<CR>==')
-- vim.keymap.set('v', '<A-j>', ":move '>+1<CR>gv=gv")
-- vim.keymap.set('v', '<A-k>', ":move '<-2<CR>gv=gv")

-- Some I took from Kickstarter
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
