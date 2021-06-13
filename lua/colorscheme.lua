-- require"base16"(require"base16".themes["onedark"],true)

-- make vim use the terminal bg
vim.cmd([[
if (has("autocmd") && !has("gui_running"))
	augroup colorset
		autocmd!
		let white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
		autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": white })
	augroup END
endif
]])
vim.g.onedark_hide_endofbuffer=1
vim.g.onedark_terminal_italics=1
vim.g.onedark_termcolors=256
vim.cmd('colorscheme ' .. O.colorscheme)
